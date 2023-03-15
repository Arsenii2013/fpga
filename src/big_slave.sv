`timescale 1ns / 1ps

module big_slave 
#(
	parameter BAR0_AW         = 16,
	parameter BAR0_DW         = 64,
	parameter BAR0_MAX_BURST  = 1,
	parameter BAR2_AW         = 16,
	parameter BAR2_DW         = 64,
	parameter BAR2_MAX_BURST  = 1,
	parameter PAGE_COUNT      = 4,
	parameter PAGE_SIZE       = 64
)
(
	input logic clock,
	input logic reset,
	avmm_if.slave bar0,
	avmm_if.slave bar2
);	
	localparam PCW	= $clog2(PAGE_COUNT);
	
	logic [PCW-1:0] page_number;
	
	page_selector #(.DW(BAR0_DW), .AW(BAR0_AW), .MAX_BURST(BAR0_MAX_BURST), .PAGE_COUNT(PAGE_COUNT))
	selector(clock, reset, bar0, page_number);
	
	page_controller #(.DW(BAR2_DW), .AW(BAR2_AW), .MAX_BURST(BAR2_MAX_BURST), .PAGE_SIZE(PAGE_SIZE), .PAGE_COUNT(PAGE_COUNT))
	controller(clock, reset, bar2, page_number);	
endmodule


