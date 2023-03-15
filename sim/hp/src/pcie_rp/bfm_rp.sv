`ifndef __BFM_RP_SV__
`define __BFM_RP_SV__

module bfm_rp
(
    output logic        refclk,
    output logic        npor,
    output logic        pin_perst,

    output logic [31:0] test_in,
    output logic        simu_mode_pipe,
    output logic        sim_pipe_pclk_in,
    input  logic [1:0]  sim_pipe_rate,
    input  logic [4:0]  sim_ltssmstate,

    output logic        rx0,
    input  logic        tx0,

    pipe_if.rp          pipe
);

//------------------------------------------------
//
//		Instances
//
altpcie_tbed_sv_hwtcl  # (
   .pll_refclk_freq_hwtcl                 ( "100 MHz"         ),
   .gen123_lane_rate_mode_hwtcl           ( "Gen2 (5.0 Gbps)" ),
   .lane_mask_hwtcl                       ( "x1"              ),
   .apps_type_hwtcl                       ( 4                 ),
   .port_type_hwtcl                       ( "Native endpoint" ),
   .enable_pipe32_sim_hwtcl               ( 1                 ),
   .enable_pipe32_phyip_ser_driver_hwtcl  ( 0                 ),
   .enable_tl_only_sim_hwtcl              ( 0                 ),
   .deemphasis_enable_hwtcl               ( "false"           ),
   .pld_clk_MHz                           ( 125               ),
   .millisecond_cycle_count_hwtcl         ( 124250            ),
   .use_crc_forwarding_hwtcl              ( 0                 ),
   .ecrc_check_capable_hwtcl              ( 0                 ),
   .ecrc_gen_capable_hwtcl                ( 0                 ),
   .serial_sim_hwtcl                      ( 0                 )
)
altpcie_tbed_sv_hwtcl_inst
(
   .refclk           ( refclk             ),
   .npor             ( npor               ),
   .pin_perst        ( pin_perst          ),

   .simu_mode_pipe   ( simu_mode_pipe     ),
   .test_in          ( test_in            ),
   .sim_pipe_rate    ( sim_pipe_rate      ),
   .sim_ltssmstate   ( sim_ltssmstate     ),
   .sim_pipe_pclk_in ( sim_pipe_pclk_in   ),

   .tlbfm_in         ( '0                 ),
   .tlbfm_out        (                    ),

   .phystatus0       ( pipe.phystatus     ),
   .rxdata0          ( pipe.rxdata        ),
   .rxdatak0         ( pipe.rxdatak       ),
   .rxelecidle0      ( pipe.rxelecidle    ),
   .rxstatus0        ( pipe.rxstatus      ),
   .rxvalid0         ( pipe.rxvalid       ),

   .eidleinfersel0   ( pipe.eidleinfersel ),
   .powerdown0       ( pipe.powerdown     ),
   .rxpolarity0      ( pipe.rxpolarity    ),
   .txcompl0         ( pipe.txcompl       ),
   .txdata0          ( pipe.txdata        ),
   .txdatak0         ( pipe.txdatak       ),
   .txdetectrx0      ( pipe.txdetectrx    ),
   .txelecidle0      ( pipe.txelecidle    ),
   .txmargin0        ( pipe.txmargin      ),
   .txswing0         ( pipe.txswing       ),
   .txdeemph0        ( pipe.txdeemph      ),

   .rx_in0           ( rx0                ),
   .tx_out0          ( tx0                ),

   .eidleinfersel1   ( '0                 ),
   .eidleinfersel2   ( '0                 ),
   .eidleinfersel3   ( '0                 ),
   .eidleinfersel4   ( '0                 ),
   .eidleinfersel5   ( '0                 ),
   .eidleinfersel6   ( '0                 ),
   .eidleinfersel7   ( '0                 ),
   .powerdown1       ( '0                 ),
   .powerdown2       ( '0                 ),
   .powerdown3       ( '0                 ),
   .powerdown4       ( '0                 ),
   .powerdown5       ( '0                 ),
   .powerdown6       ( '0                 ),
   .powerdown7       ( '0                 ),
   .rxpolarity1      ( '0                 ),
   .rxpolarity2      ( '0                 ),
   .rxpolarity3      ( '0                 ),
   .rxpolarity4      ( '0                 ),
   .rxpolarity5      ( '0                 ),
   .rxpolarity6      ( '0                 ),
   .rxpolarity7      ( '0                 ),
   .txcompl1         ( '0                 ),
   .txcompl2         ( '0                 ),
   .txcompl3         ( '0                 ),
   .txcompl4         ( '0                 ),
   .txcompl5         ( '0                 ),
   .txcompl6         ( '0                 ),
   .txcompl7         ( '0                 ),
   .txdata1          ( '0                 ),
   .txdata2          ( '0                 ),
   .txdata3          ( '0                 ),
   .txdata4          ( '0                 ),
   .txdata5          ( '0                 ),
   .txdata6          ( '0                 ),
   .txdata7          ( '0                 ),
   .txdatak1         ( '0                 ),
   .txdatak2         ( '0                 ),
   .txdatak3         ( '0                 ),
   .txdatak4         ( '0                 ),
   .txdatak5         ( '0                 ),
   .txdatak6         ( '0                 ),
   .txdatak7         ( '0                 ),
   .txdetectrx1      ( '0                 ),
   .txdetectrx2      ( '0                 ),
   .txdetectrx3      ( '0                 ),
   .txdetectrx4      ( '0                 ),
   .txdetectrx5      ( '0                 ),
   .txdetectrx6      ( '0                 ),
   .txdetectrx7      ( '0                 ),
   .txelecidle1      ( '0                 ),
   .txelecidle2      ( '0                 ),
   .txelecidle3      ( '0                 ),
   .txelecidle4      ( '0                 ),
   .txelecidle5      ( '0                 ),
   .txelecidle6      ( '0                 ),
   .txelecidle7      ( '0                 ),
   .txmargin1        ( '0                 ),
   .txmargin2        ( '0                 ),
   .txmargin3        ( '0                 ),
   .txmargin4        ( '0                 ),
   .txmargin5        ( '0                 ),
   .txmargin6        ( '0                 ),
   .txmargin7        ( '0                 ),
   .txswing1         ( '0                 ),
   .txswing2         ( '0                 ),
   .txswing3         ( '0                 ),
   .txswing4         ( '0                 ),
   .txswing5         ( '0                 ),
   .txswing6         ( '0                 ),
   .txswing7         ( '0                 ),
   .txdeemph1        ( '0                 ),
   .txdeemph2        ( '0                 ),
   .txdeemph3        ( '0                 ),
   .txdeemph4        ( '0                 ),
   .txdeemph5        ( '0                 ),
   .txdeemph6        ( '0                 ),
   .txdeemph7        ( '0                 ),

   .tx_out1          ( '0                 ),
   .tx_out2          ( '0                 ),
   .tx_out3          ( '0                 ),
   .tx_out4          ( '0                 ),
   .tx_out5          ( '0                 ),
   .tx_out6          ( '0                 ),
   .tx_out7          ( '0                 )
);
//------------------------------------------------
endmodule // bfm_rp

`endif // __BFM_RP_SV__