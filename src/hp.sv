`ifndef __HP_SV__
`define __HP_SV__

// synopsys translate off
`define SIMULATOR
// synopsys translate on

`include "hp.svh"

module hp import hp_pkg::*; 
(
`ifdef SIMULATOR
    input  logic [     31:0] test_in,
    input  logic             simu_mode_pipe,
    input  logic             sim_pipe_pclk_in,
    output logic [      1:0] sim_pipe_rate,
    output logic [      4:0] sim_ltssmstate,
    pipe_if.ep               pipe,
`endif // SIMULATOR
    
    input  logic             sysclk,

    input  logic             pci_refclk,
    input  logic             pci_perst_n,
    input  logic             pci_rx,
    output logic             pci_tx,

    output logic [      3:0] led
);

//------------------------------------------------
`timescale 1ns / 1ps

//------------------------------------------------
//
//      Objects
//
logic clk;
logic rst;

//------------------------------------------------
//
//      Interfaces
//
avmm_if #(
    .AW        ( BAR0_ADDR_W     ), 
    .DW        ( BAR0_DATA_W     ), 
    .MAX_BURST ( BAR0_MAX_BURST  )
)  bar0_i();

avmm_if #(
    .AW        ( MMR_ADDR_W      ), 
    .DW        ( MMR_DATA_W      ), 
    .MAX_BURST ( MMR_MAX_BURST   )
)  bar0_32_i();

avmm_if #(
    .AW        ( MMR_DEV_ADDR_W  ), 
    .DW        ( MMR_DATA_W      ), 
    .MAX_BURST ( MMR_MAX_BURST   )
)  mmr_i[MMR_DEV_COUNT]();

//------------------------------------------------
avmm_if #(
    .AW        ( BAR1_ADDR_W     ),
    .DW        ( BAR1_DATA_W     ),
    .MAX_BURST ( BAR1_MAX_BURST  )
)  bar1_i();

avmm_if #(
    .AW        ( BAR2_ADDR_W     ),
    .DW        ( BAR2_DATA_W     ), 
    .MAX_BURST ( BAR2_MAX_BURST  )
)  bar2_i();

//------------------------------------------------
assign clk = sysclk;

//------------------------------------------------
//
//      Instances
//
pcie_m pcie
(
    `ifdef SIMULATOR
    .test_in             ( test_in            ),
    .simu_mode_pipe      ( simu_mode_pipe     ),
    .sim_pipe_pclk_in    ( sim_pipe_pclk_in   ),
    .sim_pipe_rate       ( sim_pipe_rate      ),
    .sim_ltssmstate      ( sim_ltssmstate     ),
    .pipe                ( pipe               ),
    `endif // SIMULATOR
     
    .sysclk              ( sysclk             ),

    .refclk              ( pci_refclk         ),
    .perst_n             ( pci_perst_n        ),
    .rx                  ( pci_rx             ),
    .tx                  ( pci_tx             ),
    .status              (                    ),

    .app_clk             ( clk                ),
    .app_rst             ( rst                ),
    .bar0                ( bar0_i             ),
    .bar1                ( bar1_i             ),
    .bar2                ( bar2_i             ),

    .irq                 ( '0                 )
);
//------------------------------------------------
avmm_dw_translator_m #(
    .AW                  ( BAR0_ADDR_W        )
)
avmm_dw_translator
(
    .clk                 ( clk                ),
    .m                   ( bar0_i             ),
    .s                   ( bar0_32_i          )
);
//------------------------------------------------
avmm_crossbar_m #(
    .AW                  ( MMR_ADDR_W         ),
    .DW                  ( MMR_DATA_W         ),
    .N                   ( MMR_DEV_COUNT      ),
    .BAW                 ( MMR_BASE_ADDR_W    ),
    .MAX_BURST           ( MMR_MAX_BURST      )
)
mmr_crossbar
(
    .clk                 ( clk                ),
    .rst                 (                    ),
    .m                   ( bar0_32_i          ),
    .s                   ( mmr_i              )
);
//------------------------------------------------
pf_m #(
    .WIDTH               ( 4                  ),
    .POR                 ( "ON"               )
)
rst_pf
(
    .clk                 ( clk                ),
    .in                  ( 0                  ),
    .out                 ( rst                )
);

localparam PAGE_SIZE  = 1024*1024*8/BAR2_DATA_W; // 1 Mb 
localparam PAGE_COUNT = 4;

big_slave #(
   .BAR0_DW(MMR_DATA_W),  .BAR0_AW(MMR_DEV_ADDR_W), .BAR0_MAX_BURST(MMR_MAX_BURST), 
   .BAR2_DW(BAR2_DATA_W), .BAR2_AW(BAR2_ADDR_W),    .BAR2_MAX_BURST(BAR2_MAX_BURST),
   .PAGE_SIZE(PAGE_SIZE), 
	.PAGE_COUNT(PAGE_COUNT)
)
mem_slave(clk, rst, mmr_i[MMR_SYS], bar2_i);
//------------------------------------------------
endmodule : hp

`endif//__HP_SV__