`timescale 1ns / 1ps

`include "hp.svh"

module hp_tb;

import hp_pkg::*;

//------------------------------------------------


//------------------------------------------------
//
//		Objects
//
logic             sysclk = 0;

logic             pci_refclk;
logic             npor;
logic [     31:0] test_in;
logic             simu_mode_pipe;
logic             sim_pipe_pclk_in;
logic [      1:0] sim_pipe_rate;
logic [      4:0] sim_ltssmstate;
logic             rx;
logic             tx;
pipe_if           pipe();


wire              n_config;
logic             n_status;
logic             conf_done;

wire              dclk;
wire              data;
logic             data_e;
logic  [7:0]      data_exp;
wire  [3:0]       msel;

//------------------------------------------------
//
//		Logic
//
always #5ns begin
    sysclk = ~sysclk;
end

//------------------------------------------------
//
//		Instances
//
bfm_rp bfm_rp_inst
(
    .refclk           ( pci_refclk       ),
    .npor             ( npor             ),
     
    .test_in          ( test_in          ),
    .simu_mode_pipe   ( simu_mode_pipe   ),
    .sim_pipe_pclk_in ( sim_pipe_pclk_in ),
    .sim_pipe_rate    ( sim_pipe_rate    ),
    .sim_ltssmstate   ( sim_ltssmstate   ),
    
    .rx0              ( rx               ),
    .tx0              ( tx               ),
    
    .pipe             ( pipe             )
);
//------------------------------------------------
hp hp_inst
(
    .sysclk           ( sysclk           ),

    .pci_refclk       ( pci_refclk       ),
    .pci_perst_n      ( npor             ),
     
    .test_in          ( test_in          ),
    .simu_mode_pipe   ( simu_mode_pipe   ),
    .sim_pipe_pclk_in ( sim_pipe_pclk_in ),
    .sim_pipe_rate    ( sim_pipe_rate    ),
    .sim_ltssmstate   ( sim_ltssmstate   ),
    
    .pci_rx           ( rx               ),
    .pci_tx           ( tx               ),
    
    .pipe             ( pipe             ),
    .n_config         ( n_config         ),
    .n_status         ( n_status         ),
    .conf_done        ( conf_done        ),
    .dclk             ( dclk             ),
    .data             ( data             ),
    .msel             ( msel             )
);
//------------------------------------------------
endmodule : hp_tb