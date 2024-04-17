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
    
`ifndef SIMULATOR
    output logic [     15:0] memory_mem_a,
    output logic [      2:0] memory_mem_ba,
    output logic             memory_mem_ck,
    output logic             memory_mem_ck_n,
    output logic             memory_mem_cke,
    output logic             memory_mem_cs_n,
    output logic             memory_mem_ras_n,
    output logic             memory_mem_cas_n,
    output logic             memory_mem_we_n,
    output logic             memory_mem_reset_n,
    inout  wire  [     31:0] memory_mem_dq,
    inout  wire  [      3:0] memory_mem_dqs,
    inout  wire  [      3:0] memory_mem_dqs_n,
    output logic             memory_mem_odt,
    output logic [      3:0] memory_mem_dm,
    input  wire              memory_oct_rzqin,

   	inout  wire              hps_qspi_IO0,
	inout  wire              hps_qspi_IO1,
	inout  wire              hps_qspi_IO2,
	inout  wire              hps_qspi_IO3,
	output logic             hps_qspi_SS0,
	output logic             hps_qspi_CLK,

    output logic             hps_emac1_TX_CLK,
    output logic             hps_emac1_TXD0,
    output logic             hps_emac1_TXD1,
    output logic             hps_emac1_TXD2,
    output logic             hps_emac1_TXD3,
    input  logic             hps_emac1_RXD0,
    inout  wire              hps_emac1_MDIO,
    output logic             hps_emac1_MDC,
    input  logic             hps_emac1_RX_CTL,
    output logic             hps_emac1_TX_CTL,
    input  logic             hps_emac1_RX_CLK,
    input  logic             hps_emac1_RXD1,
    input  logic             hps_emac1_RXD2,
    input  logic             hps_emac1_RXD3,

    inout  wire              hps_gpio_GPIO44,

    input  logic             hps_uart0_RX,
    output logic             hps_uart0_TX,
`endif // SIMULATOR

    input  logic             sysclk,

    input  logic             pci_refclk,
    input  logic             pci_perst_n,
    input  logic             pci_rx,
    output logic             pci_tx,

    output logic [      3:0] led,
    
    inout  wire              n_config,
    input  logic             n_status,
    input  logic             conf_done,
    inout  wire              dclk,
    inout  wire              data,
    inout  wire [      1:0]  msel,
    inout  wire              n_ce
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

logic [16:0] test_data;
page_selector #(.DW(MMR_DATA_W), .AW(MMR_DEV_ADDR_W), .MAX_BURST(MMR_MAX_BURST), .PAGE_COUNT(2**16))
test(clk, rst, mmr_i[MMR_SYS], test_data);

assign led = test_data[3:0];

`ifdef SIMULATOR
localparam PAGE_SIZE  = 128*8/BAR2_DATA_W; // 128 b 
localparam PAGE_COUNT = 4;                 // 512 b
`endif // SIMULATOR

`ifndef SIMULATOR
localparam PAGE_SIZE  = 1024*1024*8/BAR2_DATA_W; // 1 Mb 
localparam PAGE_COUNT = 2048;                    // 2 Gb - 2048 pages of 1 Mb
`endif // SIMULATOR
localparam MEM_AW     = $clog2(PAGE_COUNT) + $clog2(PAGE_SIZE) + $clog2(SDRAM_DW/8);
localparam PCW		  = $clog2(PAGE_COUNT);

logic [PCW-1:0] bar2_page_number;

page_selector #(.DW(MMR_DATA_W), .AW(MMR_DEV_ADDR_W), .MAX_BURST(MMR_MAX_BURST), .PAGE_COUNT(PAGE_COUNT))
selector(clk, rst, mmr_i[MMR_PAGE_N], bar2_page_number);

logic [MEM_AW-1:0]   start_addr = '0;
logic  start;
logic  error;
logic  ready;

load_controller #(.DW(MMR_DATA_W), .AW(MMR_DEV_ADDR_W), .MAX_BURST(MMR_MAX_BURST), .PAGE_COUNT(PAGE_COUNT))
ctr
(
	clk, 
    rst, 
    mmr_i[MMR_LOAD],
    start_addr,
    start,
    error,
    ready,
    
    n_config,
    n_status,
    conf_done,
    dclk,
    data,
    msel,
    n_ce
);	

localparam LOADER_ADDR_W    = SDRAM_AW;
localparam LOADER_DATA_W    = SDRAM_DW; 
localparam LOADER_MAX_BURST = 1;

avmm_if #(
    .AW        ( LOADER_ADDR_W     ),
    .DW        ( LOADER_DATA_W     ), 
    .MAX_BURST ( LOADER_MAX_BURST  )
)  loader_i();

logic [PCW-1:0] loader_page_number;

wire [1:0] unused;

iv_loader
#(
    .LOADER_AW(LOADER_ADDR_W),
    .LOADER_DW(LOADER_DATA_W),
    .PAGE_COUNT(PAGE_COUNT),
	.PAGE_SIZE(PAGE_SIZE),
    .PERIOD(CLK_PRD) // 10 Mhz
)
loader
(
    .clock(clk),
    .reset(rst),
    
    .n_config_tri(n_config),
    .n_status_async(n_status),
    .conf_done_async(conf_done),
    .dclk_tri(dclk),
    .data_tri(data),
    .msel_tri({unused, msel}),
    
    
    .start(start),
    .error(error),
    .ready(ready),
    .start_addr(start_addr),
    .loader_i(loader_i),
    .page_number(loader_page_number)
);

hps_wrapper_m #(
    .BAR2_AW             ( BAR2_ADDR_W        ),
    .BAR2_DW             ( BAR2_DATA_W        ),
	.PAGE_COUNT          ( PAGE_COUNT         ),
	.PAGE_SIZE           ( PAGE_SIZE          ),
    .LOADER_AW           ( LOADER_ADDR_W      ),
    .LOADER_DW           ( LOADER_DATA_W      )
)
hps_wrapper
(   
    `ifndef SIMULATOR
    .memory_mem_a        ( memory_mem_a       ),
    .memory_mem_ba       ( memory_mem_ba      ),
    .memory_mem_ck       ( memory_mem_ck      ),
    .memory_mem_ck_n     ( memory_mem_ck_n    ),
    .memory_mem_cke      ( memory_mem_cke     ),
    .memory_mem_cs_n     ( memory_mem_cs_n    ),
    .memory_mem_ras_n    ( memory_mem_ras_n   ),
    .memory_mem_cas_n    ( memory_mem_cas_n   ),
    .memory_mem_we_n     ( memory_mem_we_n    ),
    .memory_mem_reset_n  ( memory_mem_reset_n ),
    .memory_mem_dq       ( memory_mem_dq      ),
    .memory_mem_dqs      ( memory_mem_dqs     ),
    .memory_mem_dqs_n    ( memory_mem_dqs_n   ),
    .memory_mem_odt      ( memory_mem_odt     ),
    .memory_mem_dm       ( memory_mem_dm      ),
    .memory_oct_rzqin    ( memory_oct_rzqin   ),

    .hps_uart0_RX        ( hps_uart0_RX       ),
    .hps_uart0_TX        ( hps_uart0_TX       ),

    .hps_emac1_TX_CLK    ( hps_emac1_TX_CLK   ),
    .hps_emac1_TXD0      ( hps_emac1_TXD0     ),
    .hps_emac1_TXD1      ( hps_emac1_TXD1     ),
    .hps_emac1_TXD2      ( hps_emac1_TXD2     ),
    .hps_emac1_TXD3      ( hps_emac1_TXD3     ),
    .hps_emac1_RXD0      ( hps_emac1_RXD0     ),
    .hps_emac1_MDIO      ( hps_emac1_MDIO     ),
    .hps_emac1_MDC       ( hps_emac1_MDC      ),
    .hps_emac1_RX_CTL    ( hps_emac1_RX_CTL   ),
    .hps_emac1_TX_CTL    ( hps_emac1_TX_CTL   ),
    .hps_emac1_RX_CLK    ( hps_emac1_RX_CLK   ),
    .hps_emac1_RXD1      ( hps_emac1_RXD1     ),
    .hps_emac1_RXD2      ( hps_emac1_RXD2     ),
    .hps_emac1_RXD3      ( hps_emac1_RXD3     ),

    .hps_gpio_GPIO44     ( hps_gpio_GPIO44    ),

    .hps_qspi_IO0        ( hps_qspi_IO0       ),
    .hps_qspi_IO1        ( hps_qspi_IO1       ),
    .hps_qspi_IO2        ( hps_qspi_IO2       ),
    .hps_qspi_IO3        ( hps_qspi_IO3       ),
    .hps_qspi_SS0        ( hps_qspi_SS0       ),
    .hps_qspi_CLK        ( hps_qspi_CLK       ),
    `endif // SIMULATOR

    .clk                 ( clk                ),
    .bar2_i              ( bar2_i             ),
    .bar2_page_number    ( bar2_page_number   ),
    
    .loader_i            ( loader_i           ),
    .loader_page_number  ( loader_page_number )
);
//------------------------------------------------
endmodule : hp

`endif//__HP_SV__