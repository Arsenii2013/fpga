`ifndef __HS_SPI_SV__
`define __HS_SPI_SV__

//------------------------------------------------
module hs_spi_master_m
#(
    parameter DW    = 32,
    parameter SPI_W = 4
)
(
    input  logic              clk,
    input  logic              oclk,
    input  logic              rst,

    input  logic              load,
    output logic              ready,
    output logic              valid,
    input  logic [    DW-1:0] data_in,
    output logic [    DW-1:0] data_out,


    output logic              SCK,
    output logic              CSn,
    input  logic [ SPI_W-1:0] MISO,
    output logic [ SPI_W-1:0] MOSI
);

//------------------------------------------------
`timescale 1ns / 1ps

//------------------------------------------------
//
//      Parameters
//
localparam SLICE_COUNT = DW / SPI_W;

//------------------------------------------------
//
//      Types
//
typedef logic [                 DW-1:0] data_t;
typedef logic [              SPI_W-1:0] slice_t;
typedef logic [$clog2(SLICE_COUNT)-1:0] slice_cnt_t;

typedef enum
{
    spiIDLE,
    spiTRANSFER
} state_t;

//------------------------------------------------
//
//      Objects
//
data_t      databuf;
data_t      tx_sr = '0;
data_t      rx_sr = '0;

state_t     tx_state = spiIDLE;
state_t     rx_state = spiIDLE;
slice_cnt_t tx_cnt   = '0;
slice_cnt_t rx_cnt   = '0;

logic       empty    = 1;

//------------------------------------------------
//
//      Logic
//
assign ready    = empty;
assign data_out = rx_sr;

//------------------------------------------------
always_ff @(posedge clk) begin : tx
    
    MOSI <= tx_sr[DW-1:DW-SPI_W];

    if (rst) begin
        tx_state <= spiIDLE;
        CSn      <= 1;
        empty    <= 1;
    end
    else begin
        if (empty & load) begin
            databuf <= data_in;
            empty   <= 0;
        end

        case (tx_state)
            spiIDLE: begin
                CSn <= 1;
                if (!empty) begin
                    CSn      <= 0;
                    tx_sr    <= databuf;
                    empty    <= 1;
                    tx_state <= spiTRANSFER;
                end
            end
            spiTRANSFER: begin
                tx_sr[DW-1:SPI_W] <= tx_sr[DW-SPI_W-1:0];
                CSn <= 0;
                if (tx_cnt == slice_cnt_t'(SLICE_COUNT-1)) begin
                    tx_cnt   <= 0;
                    CSn      <= 1;
                    tx_state <= spiIDLE;
                end
                else begin
                    tx_cnt   <= tx_cnt + slice_cnt_t'(1);
                end
            end
        endcase
    end
end

//------------------------------------------------
always_ff @(posedge clk) begin : rx

    rx_sr[SPI_W-1:0] <= MISO;

    if (rst) begin
        rx_state <= spiIDLE;
        valid    <= 0;
    end
    else begin
        case (rx_state)
            spiIDLE: begin
                valid <= 0;
                if (tx_state == spiTRANSFER) rx_state <= spiTRANSFER;
            end
            spiTRANSFER: begin
                rx_sr[DW-1:SPI_W] <= rx_sr[DW-SPI_W-1:0];
                if (rx_cnt == slice_cnt_t'(SLICE_COUNT-1)) begin
                    rx_cnt   <= 0;
                    valid    <= 1;
                    rx_state <= spiIDLE;
                end
                else begin
                    rx_cnt   <= rx_cnt + slice_cnt_t'(1);
                end
            end
        endcase
    end
end

//------------------------------------------------
//
//      Instances
//
oddr_m sck_out
(
    .datain_h   ( 1    ),
    .datain_l   ( 0    ),
    .outclocken ( 1    ),
    .outclock   ( oclk ),
    .dataout    ( SCK  )
);

//------------------------------------------------
endmodule : hs_spi_master_m



//------------------------------------------------
module hs_spi_slave_m
#(
    parameter DW    = 32,
    parameter SPI_W = 4,
    parameter TCO   = 10ns
)
(
    output logic              clkout,
    input  logic              rst,

    input  logic              load,
    output logic              ready,
    output logic              valid,
    input  logic [    DW-1:0] data_in,
    output logic [    DW-1:0] data_out,


    input  logic              SCK,
    input  logic              CSn,
    output logic [ SPI_W-1:0] MISO,
    input  logic [ SPI_W-1:0] MOSI
);

//------------------------------------------------
`timescale 1ns / 1ps

//------------------------------------------------
//
//      Parameters
//
localparam SLICE_COUNT = DW / SPI_W;

//------------------------------------------------
//
//      Types
//
typedef logic [                 DW-1:0] data_t;
typedef logic [              SPI_W-1:0] slice_t;
typedef logic [$clog2(SLICE_COUNT)-1:0] slice_cnt_t;

typedef enum
{
    spiIDLE,
    spiTRANSFER
} state_t;

//------------------------------------------------
//
//      Objects
//
data_t      databuf;
data_t      tx_sr = '0;
data_t      rx_sr = '0;

logic       cs_n;
state_t     rx_state;
slice_cnt_t rx_cnt = '0;

logic       empty  = 1;
logic       update = 0;

//------------------------------------------------
//
//      Logic
//
assign clkout = SCK;

//------------------------------------------------
always_ff @(posedge SCK) cs_n <= CSn;

//------------------------------------------------
assign data_out = rx_sr;
assign rx_state = cs_n ? spiIDLE : spiTRANSFER;

always_ff @(posedge SCK) begin : rx

    rx_sr[SPI_W-1:0] <= MOSI;

    if (rst) begin
        valid <= 0;
    end
    else begin
        case (rx_state)
            spiIDLE: begin
                valid <= 0;
            end
            spiTRANSFER: begin
                rx_sr[DW-1:SPI_W] <= rx_sr[DW-SPI_W-1:0];
                if (rx_cnt == slice_cnt_t'(SLICE_COUNT-1)) begin
                    rx_cnt <= 0;
                    valid  <= 1;
                end
                else begin
                    rx_cnt <= rx_cnt + slice_cnt_t'(1);
                end
            end
        endcase
    end
end

//------------------------------------------------
assign ready = empty;

always_ff @(posedge SCK) begin : tx

    MISO <= #TCO cs_n ? tx_sr[DW-1:DW-SPI_W] : tx_sr[DW-SPI_W-1:DW-2*SPI_W];

    if (rst) begin
        empty <= 1;
    end
    else begin
        if (empty & load) begin
            databuf <= data_in;
            empty   <= 0;
        end

        if (cs_n) begin
            if (!empty) begin
                tx_sr  <= databuf;
                update <= 1;
            end
        end
        else begin
            tx_sr[DW-1:SPI_W] <= tx_sr[DW-SPI_W-1:0];
            if (update) begin
                update <= 0;
                empty  <= 1;
            end
        end
    end
end

//------------------------------------------------
endmodule : hs_spi_slave_m

//------------------------------------------------
`endif // __HS_SPI_SV__