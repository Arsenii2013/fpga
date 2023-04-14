`ifndef __HPS_WRAPPER_SV__
`define __HPS_WRAPPER_SV__

// synopsys translate off
`define SIMULATOR
// synopsys translate on

`include "hp.svh"

module hps_wrapper_m import hp_pkg::*;
#(
    parameter BAR2_AW         = 32,
    parameter BAR2_DW         = 32,
	parameter PAGE_COUNT      = 4,
	parameter PAGE_SIZE       = 64,
	parameter LOADER_AW       = 64,
	parameter LOADER_DW       = 64,
    
	parameter PCW		      = $clog2(PAGE_COUNT)
)
(  
    `ifndef SIMULATOR
    output logic [        15:0] memory_mem_a,
    output logic [         2:0] memory_mem_ba,
    output logic                memory_mem_ck,
    output logic                memory_mem_ck_n,
    output logic                memory_mem_cke,
    output logic                memory_mem_cs_n,
    output logic                memory_mem_ras_n,
    output logic                memory_mem_cas_n,
    output logic                memory_mem_we_n,
    output logic                memory_mem_reset_n,
    inout  wire  [        31:0] memory_mem_dq,
    inout  wire  [         3:0] memory_mem_dqs,
    inout  wire  [         3:0] memory_mem_dqs_n,
    output logic                memory_mem_odt,
    output logic [         3:0] memory_mem_dm,
    input  wire                 memory_oct_rzqin,

   	inout  wire                 hps_qspi_IO0,
	inout  wire                 hps_qspi_IO1,
	inout  wire                 hps_qspi_IO2,
	inout  wire                 hps_qspi_IO3,
	output logic                hps_qspi_SS0,
	output logic                hps_qspi_CLK,

    output logic                hps_emac1_TX_CLK,
    output logic                hps_emac1_TXD0,
    output logic                hps_emac1_TXD1,
    output logic                hps_emac1_TXD2,
    output logic                hps_emac1_TXD3,
    input  logic                hps_emac1_RXD0,
    inout  wire                 hps_emac1_MDIO,
    output logic                hps_emac1_MDC,
    input  logic                hps_emac1_RX_CTL,
    output logic                hps_emac1_TX_CTL,
    input  logic                hps_emac1_RX_CLK,
    input  logic                hps_emac1_RXD1,
    input  logic                hps_emac1_RXD2,
    input  logic                hps_emac1_RXD3,

    inout  wire                 hps_gpio_GPIO44,

    input  logic                hps_uart0_RX,
    output logic                hps_uart0_TX,
    `endif // SIMULATOR

    input  logic                clk,
    avmm_if.slave               bar2_i,
    input  logic [PCW-1:0]      bar2_page_number,
    
    avmm_if.slave               loader_i,
    input  logic [PCW-1:0]      loader_page_number
);

//------------------------------------------------
`timescale 1ns / 1ps

//------------------------------------------------
//
//      Parameters
//

// Учесть что адресация в словах
localparam FPGA_IF_OFFSET  = SDRAM_OFFSET / (SDRAM_DW/8);
localparam FPGA_IF_ALIGN   = $clog2(SDRAM_DW/8);
localparam FPGA_IF_AW      = SDRAM_AW - FPGA_IF_ALIGN;

//------------------------------------------------
//
//      Types
//
typedef logic [FPGA_IF_AW-1:0] bridge_addr_t;

//------------------------------------------------
//
//      Objects
//
bridge_addr_t sdram0_address;
bridge_addr_t sdram1_address;

//------------------------------------------------
//
//      Logic
//
logic [SDRAM_AW + PCW - 1:0] bar2_page_start;
assign bar2_page_start     = PAGE_SIZE*bar2_page_number*BAR2_DW/8;
assign sdram0_address = bridge_addr_t'(bar2_i.address[BAR2_AW-1:FPGA_IF_ALIGN]) + 
                        bridge_addr_t'(bar2_page_start[SDRAM_AW + PCW - 1:FPGA_IF_ALIGN]);
                        
logic [SDRAM_AW + PCW - 1:0] loader_page_start;
assign loader_page_start     = PAGE_SIZE*loader_page_number*LOADER_DW/8;
assign sdram1_address = bridge_addr_t'(loader_i.address[LOADER_AW-1:FPGA_IF_ALIGN]) + 
                        bridge_addr_t'(loader_page_start[SDRAM_AW + PCW - 1:FPGA_IF_ALIGN]);

//------------------------------------------------
`ifndef SIMULATOR
    hps_m hps
    (
        .memory_mem_a                     ( memory_mem_a        ),
        .memory_mem_ba                    ( memory_mem_ba       ),
        .memory_mem_ck                    ( memory_mem_ck       ),
        .memory_mem_ck_n                  ( memory_mem_ck_n     ),
        .memory_mem_cke                   ( memory_mem_cke      ),
        .memory_mem_cs_n                  ( memory_mem_cs_n     ),
        .memory_mem_ras_n                 ( memory_mem_ras_n    ),
        .memory_mem_cas_n                 ( memory_mem_cas_n    ),
        .memory_mem_we_n                  ( memory_mem_we_n     ),
        .memory_mem_reset_n               ( memory_mem_reset_n  ),
        .memory_mem_dq                    ( memory_mem_dq       ),
        .memory_mem_dqs                   ( memory_mem_dqs      ),
        .memory_mem_dqs_n                 ( memory_mem_dqs_n    ),
        .memory_mem_odt                   ( memory_mem_odt      ),
        .memory_mem_dm                    ( memory_mem_dm       ),
        .memory_oct_rzqin                 ( memory_oct_rzqin    ),

        .hps_io_hps_io_uart0_inst_RX      ( hps_uart0_RX        ),
        .hps_io_hps_io_uart0_inst_TX      ( hps_uart0_TX        ),

        .hps_io_hps_io_qspi_inst_IO0      ( hps_qspi_IO0        ),
        .hps_io_hps_io_qspi_inst_IO1      ( hps_qspi_IO1        ),
        .hps_io_hps_io_qspi_inst_IO2      ( hps_qspi_IO2        ),
        .hps_io_hps_io_qspi_inst_IO3      ( hps_qspi_IO3        ),
        .hps_io_hps_io_qspi_inst_SS0      ( hps_qspi_SS0        ),
        .hps_io_hps_io_qspi_inst_CLK      ( hps_qspi_CLK        ),

        .hps_io_hps_io_emac1_inst_TX_CLK  ( hps_emac1_TX_CLK    ),
        .hps_io_hps_io_emac1_inst_TXD0    ( hps_emac1_TXD0      ),
        .hps_io_hps_io_emac1_inst_TXD1    ( hps_emac1_TXD1      ),
        .hps_io_hps_io_emac1_inst_TXD2    ( hps_emac1_TXD2      ),
        .hps_io_hps_io_emac1_inst_TXD3    ( hps_emac1_TXD3      ),
        .hps_io_hps_io_emac1_inst_RXD0    ( hps_emac1_RXD0      ),
        .hps_io_hps_io_emac1_inst_MDIO    ( hps_emac1_MDIO      ),
        .hps_io_hps_io_emac1_inst_MDC     ( hps_emac1_MDC       ),
        .hps_io_hps_io_emac1_inst_RX_CTL  ( hps_emac1_RX_CTL    ),
        .hps_io_hps_io_emac1_inst_TX_CTL  ( hps_emac1_TX_CTL    ),
        .hps_io_hps_io_emac1_inst_RX_CLK  ( hps_emac1_RX_CLK    ),
        .hps_io_hps_io_emac1_inst_RXD1    ( hps_emac1_RXD1      ),
        .hps_io_hps_io_emac1_inst_RXD2    ( hps_emac1_RXD2      ),
        .hps_io_hps_io_emac1_inst_RXD3    ( hps_emac1_RXD3      ),

        .hps_io_hps_io_gpio_inst_GPIO44   ( hps_gpio_GPIO44     ),
        
        .sdram0_clk_clk                   ( clk                 ),
        .sdram0_address                   ( sdram0_address      ),
        .sdram0_burstcount                ( bar2_i.burstcount    ),
        .sdram0_waitrequest               ( bar2_i.waitrequest   ),
        .sdram0_readdata                  ( bar2_i.readdata      ),
        .sdram0_readdatavalid             ( bar2_i.readdatavalid ),
        .sdram0_read                      ( bar2_i.read          ),
        .sdram0_writedata                 ( bar2_i.writedata     ),
        .sdram0_byteenable                ( bar2_i.byteenable    ),
        .sdram0_write                     ( bar2_i.write         ),

        .sdram1_clk_clk                   ( clk                    ),
        .sdram1_address                   ( sdram1_address         ),
        .sdram1_burstcount                ( loader_i.burstcount    ),
        .sdram1_waitrequest               ( loader_i.waitrequest   ),
        .sdram1_readdata                  ( loader_i.readdata      ),
        .sdram1_readdatavalid             ( loader_i.readdatavalid ),
        .sdram1_read                      ( loader_i.read          ),
        .sdram1_writedata                 ( loader_i.writedata     ),
        .sdram1_byteenable                ( loader_i.byteenable    ),
        .sdram1_write                     ( loader_i.write         )
    );
`else  // SIMULATOR
    
    page_controller #(.DW(BAR2_DATA_W), .AW(BAR2_AW), .MAX_BURST(BAR2_MAX_BURST), .PAGE_SIZE(PAGE_SIZE), .PAGE_COUNT(PAGE_COUNT))
	bar_mem(clk, 'h0, bar2_i, bar2_page_number);
    
    page_controller #(.DW(BAR2_DATA_W), .AW(BAR2_AW), .MAX_BURST(BAR2_MAX_BURST), .PAGE_SIZE(PAGE_SIZE), .PAGE_COUNT(PAGE_COUNT))
	loader_mem(clk, 'h0, loader_i, loader_page_number);
    //------------------------------------------------
`endif // SIMULATOR
//------------------------------------------------
endmodule : hps_wrapper_m

`endif // __HPS_WRAPPER_SV__