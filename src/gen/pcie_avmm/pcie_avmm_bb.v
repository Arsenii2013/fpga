
module pcie_avmm (
	clk_clk,
	coreclkout_clk,
	cra_chipselect,
	cra_address,
	cra_byteenable,
	cra_read,
	cra_readdata,
	cra_write,
	cra_writedata,
	cra_waitrequest,
	crairq_irq,
	hip_ctrl_test_in,
	hip_ctrl_simu_mode_pipe,
	hip_pipe_sim_pipe_pclk_in,
	hip_pipe_sim_pipe_rate,
	hip_pipe_sim_ltssmstate,
	hip_pipe_eidleinfersel0,
	hip_pipe_powerdown0,
	hip_pipe_rxpolarity0,
	hip_pipe_txcompl0,
	hip_pipe_txdata0,
	hip_pipe_txdatak0,
	hip_pipe_txdetectrx0,
	hip_pipe_txelecidle0,
	hip_pipe_txswing0,
	hip_pipe_txmargin0,
	hip_pipe_txdeemph0,
	hip_pipe_phystatus0,
	hip_pipe_rxdata0,
	hip_pipe_rxdatak0,
	hip_pipe_rxelecidle0,
	hip_pipe_rxstatus0,
	hip_pipe_rxvalid0,
	hip_serial_rx_in0,
	hip_serial_tx_out0,
	hip_status_derr_cor_ext_rcv,
	hip_status_derr_cor_ext_rpl,
	hip_status_derr_rpl,
	hip_status_dlup_exit,
	hip_status_ltssmstate,
	hip_status_ev128ns,
	hip_status_ev1us,
	hip_status_hotrst_exit,
	hip_status_int_status,
	hip_status_l2_exit,
	hip_status_lane_act,
	hip_status_ko_cpl_spc_header,
	hip_status_ko_cpl_spc_data,
	irq_irq,
	irq_rcvr_clk_clk,
	irq_rcvr_rst_reset,
	m0_waitrequest,
	m0_readdata,
	m0_readdatavalid,
	m0_burstcount,
	m0_writedata,
	m0_address,
	m0_write,
	m0_read,
	m0_byteenable,
	m0_debugaccess,
	m0_clk_clk,
	m0_rst_reset,
	m1_waitrequest,
	m1_readdata,
	m1_readdatavalid,
	m1_burstcount,
	m1_writedata,
	m1_address,
	m1_write,
	m1_read,
	m1_byteenable,
	m1_debugaccess,
	m1_clk_clk,
	m1_rst_reset,
	m2_waitrequest,
	m2_readdata,
	m2_readdatavalid,
	m2_burstcount,
	m2_writedata,
	m2_address,
	m2_write,
	m2_read,
	m2_byteenable,
	m2_debugaccess,
	m2_clk_clk,
	m2_rst_reset,
	npor_npor,
	npor_pin_perst,
	nreset_status_reset_n,
	reconfig_clk_clk,
	reconfig_rst_reset,
	refclk_clk,
	reset_reset_n,
	rxmirq_irq,
	rxmirq_out_irq,
	txs_chipselect,
	txs_byteenable,
	txs_readdata,
	txs_writedata,
	txs_read,
	txs_write,
	txs_burstcount,
	txs_readdatavalid,
	txs_waitrequest,
	txs_address);	

	input		clk_clk;
	output		coreclkout_clk;
	input		cra_chipselect;
	input	[13:0]	cra_address;
	input	[3:0]	cra_byteenable;
	input		cra_read;
	output	[31:0]	cra_readdata;
	input		cra_write;
	input	[31:0]	cra_writedata;
	output		cra_waitrequest;
	output		crairq_irq;
	input	[31:0]	hip_ctrl_test_in;
	input		hip_ctrl_simu_mode_pipe;
	input		hip_pipe_sim_pipe_pclk_in;
	output	[1:0]	hip_pipe_sim_pipe_rate;
	output	[4:0]	hip_pipe_sim_ltssmstate;
	output	[2:0]	hip_pipe_eidleinfersel0;
	output	[1:0]	hip_pipe_powerdown0;
	output		hip_pipe_rxpolarity0;
	output		hip_pipe_txcompl0;
	output	[7:0]	hip_pipe_txdata0;
	output		hip_pipe_txdatak0;
	output		hip_pipe_txdetectrx0;
	output		hip_pipe_txelecidle0;
	output		hip_pipe_txswing0;
	output	[2:0]	hip_pipe_txmargin0;
	output		hip_pipe_txdeemph0;
	input		hip_pipe_phystatus0;
	input	[7:0]	hip_pipe_rxdata0;
	input		hip_pipe_rxdatak0;
	input		hip_pipe_rxelecidle0;
	input	[2:0]	hip_pipe_rxstatus0;
	input		hip_pipe_rxvalid0;
	input		hip_serial_rx_in0;
	output		hip_serial_tx_out0;
	output		hip_status_derr_cor_ext_rcv;
	output		hip_status_derr_cor_ext_rpl;
	output		hip_status_derr_rpl;
	output		hip_status_dlup_exit;
	output	[4:0]	hip_status_ltssmstate;
	output		hip_status_ev128ns;
	output		hip_status_ev1us;
	output		hip_status_hotrst_exit;
	output	[3:0]	hip_status_int_status;
	output		hip_status_l2_exit;
	output	[3:0]	hip_status_lane_act;
	output	[7:0]	hip_status_ko_cpl_spc_header;
	output	[11:0]	hip_status_ko_cpl_spc_data;
	input	[15:0]	irq_irq;
	input		irq_rcvr_clk_clk;
	input		irq_rcvr_rst_reset;
	input		m0_waitrequest;
	input	[63:0]	m0_readdata;
	input		m0_readdatavalid;
	output	[0:0]	m0_burstcount;
	output	[63:0]	m0_writedata;
	output	[15:0]	m0_address;
	output		m0_write;
	output		m0_read;
	output	[7:0]	m0_byteenable;
	output		m0_debugaccess;
	input		m0_clk_clk;
	input		m0_rst_reset;
	input		m1_waitrequest;
	input	[63:0]	m1_readdata;
	input		m1_readdatavalid;
	output	[3:0]	m1_burstcount;
	output	[63:0]	m1_writedata;
	output	[16:0]	m1_address;
	output		m1_write;
	output		m1_read;
	output	[7:0]	m1_byteenable;
	output		m1_debugaccess;
	input		m1_clk_clk;
	input		m1_rst_reset;
	input		m2_waitrequest;
	input	[63:0]	m2_readdata;
	input		m2_readdatavalid;
	output	[3:0]	m2_burstcount;
	output	[63:0]	m2_writedata;
	output	[19:0]	m2_address;
	output		m2_write;
	output		m2_read;
	output	[7:0]	m2_byteenable;
	output		m2_debugaccess;
	input		m2_clk_clk;
	input		m2_rst_reset;
	input		npor_npor;
	input		npor_pin_perst;
	output		nreset_status_reset_n;
	input		reconfig_clk_clk;
	input		reconfig_rst_reset;
	input		refclk_clk;
	input		reset_reset_n;
	input	[15:0]	rxmirq_irq;
	output	[15:0]	rxmirq_out_irq;
	input		txs_chipselect;
	input	[7:0]	txs_byteenable;
	output	[63:0]	txs_readdata;
	input	[63:0]	txs_writedata;
	input		txs_read;
	input		txs_write;
	input	[6:0]	txs_burstcount;
	output		txs_readdatavalid;
	output		txs_waitrequest;
	input	[12:0]	txs_address;
endmodule
