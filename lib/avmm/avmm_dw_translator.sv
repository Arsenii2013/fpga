`ifndef __AVMM_DW_TRANSLATOR__
`define __AVMM_DW_TRANSLATOR__

// converts single 32-bit data transaction via 64-bit avalon-mm bus
// to single 32-bit data transaction via 32-bit avalon-mm bus

module avmm_dw_translator_m
#(
    parameter AW = 16
)
(
    input logic    clk,

    avmm_if.slave  m,
    avmm_if.master s
);

//------------------------------------------------
`timescale 1ns / 1ps

localparam L = 8'h0F;
localparam H = 8'hF0;

typedef logic [AW-1:0] addr_t;
typedef logic [   7:0] mask_t;
typedef logic [  31:0] data_t;

addr_t addr;
addr_t s_addr;
mask_t mask;
mask_t s_mask;
data_t data_l;
data_t data_h;

always_ff @(posedge clk) begin
    if (m.write || m.read) begin
        addr <= m.address;
        mask <= m.byteenable;
    end
end

assign s_addr = (m.write | m.read) ? m.address : addr;
assign s_mask = (m.write | m.read) ? m.byteenable : mask;
assign data_l = m.writedata[31:0];
assign data_h = m.writedata[63:32];

always_comb begin
    s.address         = s_mask == L ? s_addr : (s_addr | addr_t'(3'b100));
    s.read            = m.read;	
    s.write           = m.write;
    s.burstcount      = m.burstcount;
    s.writedata       = s_mask == L ? data_l : data_h;
    s.byteenable      = '1;

    m.waitrequest     = s.waitrequest;
    m.readdata[31:0]  = s.readdata;
    m.readdata[63:32] = s.readdata;
    m.readdatavalid   = s.readdatavalid;
end

endmodule : avmm_dw_translator_m

`endif//__AVMM_DW_TRANSLATOR__