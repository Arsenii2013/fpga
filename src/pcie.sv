`ifndef __PCIE_SV__
`define __PCIE_SV__

// synopsys translate off
`define SIMULATOR
// synopsys translate on

module pcie_m
(
    `ifdef SIMULATOR
    input  logic [31:0] test_in,
    input  logic        simu_mode_pipe,
    input  logic        sim_pipe_pclk_in,
    output logic  [1:0] sim_pipe_rate,
    output logic  [4:0] sim_ltssmstate,
    pipe_if.ep          pipe,
    `endif // SIMULATOR

    input  logic        sysclk,

    // pci express bus
    input  logic        refclk,
    input  logic        perst_n,
    input  logic        rx,
    output logic        tx,
    output logic        status,

    // application interface
    input  logic        app_clk,
    input  logic        app_rst,

    avmm_if.master      bar0,
    avmm_if.master      bar1,
    avmm_if.master      bar2,

    input  logic [15:0] irq
);

//------------------------------------------------
`timescale 1ns / 1ps

//------------------------------------------------
//
//      Objects
//
logic        pcie_clk;
logic        pcie_rst_n;

logic  [3:0] lane_act;

logic [15:0] rxmirq;

//------------------------------------------------
//
//      Logic
//
assign status  = lane_act[0];

//------------------------------------------------
// 
//      Instances
//
pcie_avmm pcie_avmm_inst
(
    `ifdef SIMULATOR
    .hip_ctrl_test_in              ( test_in            ),
    .hip_ctrl_simu_mode_pipe       ( simu_mode_pipe     ),
    .hip_pipe_sim_pipe_pclk_in     ( sim_pipe_pclk_in   ),
    .hip_pipe_sim_pipe_rate        ( sim_pipe_rate      ),
    .hip_pipe_sim_ltssmstate       ( sim_ltssmstate     ),
    .hip_pipe_eidleinfersel0       ( pipe.eidleinfersel ),
    .hip_pipe_powerdown0           ( pipe.powerdown     ),
    .hip_pipe_rxpolarity0          ( pipe.rxpolarity    ),
    .hip_pipe_txcompl0             ( pipe.txcompl       ),
    .hip_pipe_txdata0              ( pipe.txdata        ),
    .hip_pipe_txdatak0             ( pipe.txdatak       ),
    .hip_pipe_txdetectrx0          ( pipe.txdetectrx    ),
    .hip_pipe_txelecidle0          ( pipe.txelecidle    ),
    .hip_pipe_txswing0             ( pipe.txswing       ),
    .hip_pipe_txmargin0            ( pipe.txmargin      ),
    .hip_pipe_txdeemph0            ( pipe.txdeemph      ),
    .hip_pipe_phystatus0           ( pipe.phystatus     ),
    .hip_pipe_rxdata0              ( pipe.rxdata        ),
    .hip_pipe_rxdatak0             ( pipe.rxdatak       ),
    .hip_pipe_rxelecidle0          ( pipe.rxelecidle    ),
    .hip_pipe_rxstatus0            ( pipe.rxstatus      ),
    .hip_pipe_rxvalid0             ( pipe.rxvalid       ),
    `else
    .hip_ctrl_test_in              ( 32'h88             ),
    .hip_ctrl_simu_mode_pipe       ( 1'b0               ),
    .hip_pipe_sim_pipe_pclk_in     ( 1'b0               ),
    .hip_pipe_sim_pipe_rate        (                    ), 
    .hip_pipe_sim_ltssmstate       (                    ),
    `endif // SIMULATOR

    .refclk_clk                    ( refclk             ),
    .npor_npor                     ( perst_n            ), 
    .npor_pin_perst                ( perst_n            ),
    .hip_serial_rx_in0             ( rx                 ),
    .hip_serial_tx_out0            ( tx                 ),
    .coreclkout_clk                ( pcie_clk           ),
    .nreset_status_reset_n         ( pcie_rst_n         ),
    .hip_status_lane_act           ( lane_act           ),

    // avalon-mm clock & reset (pcie side)
    .clk_clk                       ( pcie_clk           ),
    .reset_reset_n                 ( pcie_rst_n         ),

    // reconfig conbtroller clock & reset
    .reconfig_clk_clk              ( sysclk             ),
    .reconfig_rst_reset            ( 0                  ),
    
    // bar0 interface
    .m0_clk_clk                    ( app_clk            ),
    .m0_rst_reset                  ( app_rst            ),
    .m0_address                    ( bar0.address       ),
    .m0_read                       ( bar0.read          ),
    .m0_write                      ( bar0.write         ),
    .m0_burstcount                 ( bar0.burstcount    ),
    .m0_writedata                  ( bar0.writedata     ),
    .m0_byteenable                 ( bar0.byteenable    ),
    .m0_waitrequest                ( bar0.waitrequest   ),
    .m0_readdata                   ( bar0.readdata      ),
    .m0_readdatavalid              ( bar0.readdatavalid ),

     // bar1 interface
    .m1_clk_clk                    ( app_clk            ),
    .m1_rst_reset                  ( app_rst            ),
    .m1_address                    ( bar1.address       ),
    .m1_read                       ( bar1.read          ),
    .m1_write                      ( bar1.write         ),
    .m1_burstcount                 ( bar1.burstcount    ),
    .m1_writedata                  ( bar1.writedata     ),
    .m1_byteenable                 ( bar1.byteenable    ),
    .m1_waitrequest                ( bar1.waitrequest   ),
    .m1_readdata                   ( bar1.readdata      ),
    .m1_readdatavalid              ( bar1.readdatavalid ),

     // bar2 interface
    .m2_clk_clk                    ( app_clk            ),
    .m2_rst_reset                  ( app_rst            ),
    .m2_address                    ( bar2.address       ),
    .m2_read                       ( bar2.read          ),
    .m2_write                      ( bar2.write         ),
    .m2_burstcount                 ( bar2.burstcount    ),
    .m2_writedata                  ( bar2.writedata     ),
    .m2_byteenable                 ( bar2.byteenable    ),
    .m2_waitrequest                ( bar2.waitrequest   ),
    .m2_readdata                   ( bar2.readdata      ),
    .m2_readdatavalid              ( bar2.readdatavalid ),

    // cra interface
    .cra_chipselect                ( 1'b0               ),
    .cra_address                   (  '0                ),
    .cra_read                      ( 1'b0               ),
    .cra_write                     ( 1'b0               ),
    .cra_writedata                 ( '0                 ),
    .cra_byteenable                ( '0                 ),
    .cra_waitrequest               (                    ),
    .cra_readdata                  (                    ),
    .crairq_irq                    (                    ),

    // txs interface
    .txs_chipselect                ( 1'b0               ),
    .txs_address                   (  '0                ),
    .txs_read                      ( 1'b0               ),
    .txs_write                     ( 1'b0               ),
    .txs_writedata                 (  '0                ),
    .txs_byteenable                (  '0                ),
    .txs_burstcount                (  '0                ),
    .txs_waitrequest               (                    ),
    .txs_readdata                  (                    ),
    .txs_readdatavalid             (                    ),

    // interrupt
    .irq_irq                       ( irq                ),
    .irq_rcvr_clk_clk              ( app_clk            ),
    .irq_rcvr_rst_reset            ( app_rst            ),
    .rxmirq_out_irq                ( rxmirq             ),
    .rxmirq_irq                    ( rxmirq             )
);
//------------------------------------------------
endmodule : pcie_m

`endif // __PCIE_SV__