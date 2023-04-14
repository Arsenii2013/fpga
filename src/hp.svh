`ifndef __HP_SVH__
`define __HP_SVH__

package hp_pkg;

//------------------------------------------------
//
//      Common
//
localparam CLK_PRD         = 10;
localparam SYNC_PRD_DEF    = 1000;
localparam LLRF_DW         = 32;

//------------------------------------------------
//
//      PCI Express
//
localparam PCIE_DATA_W     = 64;

localparam BAR0_ADDR_W     = 16;
localparam BAR0_DATA_W     = PCIE_DATA_W;
localparam BAR0_MAX_BURST  = 1;

localparam BAR1_ADDR_W     = 17;
localparam BAR1_DATA_W     = PCIE_DATA_W;
localparam BAR1_MAX_BURST  = 8;

localparam BAR2_ADDR_W     = 20;
localparam BAR2_DATA_W     = PCIE_DATA_W;
localparam BAR2_MAX_BURST  = 8;

//------------------------------------------------
//
//      Memory mapped registers
//
localparam MMR_ADDR_W      = BAR0_ADDR_W;
localparam MMR_DATA_W      = 32;
localparam MMR_MAX_BURST   = BAR0_MAX_BURST;
localparam MMR_BASE_ADDR_W = 6;
localparam MMR_DEV_ADDR_W  = MMR_ADDR_W - MMR_BASE_ADDR_W;

localparam MMR_SYS         = '0;
localparam MMR_SCC         = MMR_SYS   + 1;
localparam MMR_IC          = MMR_SCC   + 1;
localparam MMR_EVR         = MMR_IC    + 1;
localparam MMR_EVMUX       = MMR_EVR   + 1;
localparam MMR_DMUX        = MMR_EVMUX + 1;
localparam MMR_AFE         = MMR_DMUX  + 1;
localparam MMR_LOG         = MMR_AFE   + 1;
localparam MMR_RIOC        = MMR_LOG   + 1;
localparam MMR_MFMC        = MMR_RIOC  + 1;
localparam MMR_DDSC0       = MMR_MFMC  + 1;
localparam MMR_DDSC1       = MMR_DDSC0 + 1;
localparam MMR_DDSC2       = MMR_DDSC1 + 1;
localparam MMR_DDSC3       = MMR_DDSC2 + 1;
localparam MMR_PAGE_N      = MMR_DDSC3 + 1; // page number
localparam MMR_LOAD        = MMR_PAGE_N + 1; // load control
localparam MMR_DEV_COUNT   = MMR_LOAD + 1;

//------------------------------------------------
//
//      SDRAM parameters
//
localparam SDRAM_DW        = 64;
localparam SDRAM_AW        = 32;
localparam SDRAM_OFFSET    = 32'h4000_0000;

endpackage : hp_pkg

`endif//__HP_SVH__