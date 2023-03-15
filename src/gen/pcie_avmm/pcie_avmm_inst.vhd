	component pcie_avmm is
		port (
			clk_clk                      : in  std_logic                     := 'X';             -- clk
			coreclkout_clk               : out std_logic;                                        -- clk
			cra_chipselect               : in  std_logic                     := 'X';             -- chipselect
			cra_address                  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- address
			cra_byteenable               : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			cra_read                     : in  std_logic                     := 'X';             -- read
			cra_readdata                 : out std_logic_vector(31 downto 0);                    -- readdata
			cra_write                    : in  std_logic                     := 'X';             -- write
			cra_writedata                : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			cra_waitrequest              : out std_logic;                                        -- waitrequest
			crairq_irq                   : out std_logic;                                        -- irq
			hip_ctrl_test_in             : in  std_logic_vector(31 downto 0) := (others => 'X'); -- test_in
			hip_ctrl_simu_mode_pipe      : in  std_logic                     := 'X';             -- simu_mode_pipe
			hip_pipe_sim_pipe_pclk_in    : in  std_logic                     := 'X';             -- sim_pipe_pclk_in
			hip_pipe_sim_pipe_rate       : out std_logic_vector(1 downto 0);                     -- sim_pipe_rate
			hip_pipe_sim_ltssmstate      : out std_logic_vector(4 downto 0);                     -- sim_ltssmstate
			hip_pipe_eidleinfersel0      : out std_logic_vector(2 downto 0);                     -- eidleinfersel0
			hip_pipe_powerdown0          : out std_logic_vector(1 downto 0);                     -- powerdown0
			hip_pipe_rxpolarity0         : out std_logic;                                        -- rxpolarity0
			hip_pipe_txcompl0            : out std_logic;                                        -- txcompl0
			hip_pipe_txdata0             : out std_logic_vector(7 downto 0);                     -- txdata0
			hip_pipe_txdatak0            : out std_logic;                                        -- txdatak0
			hip_pipe_txdetectrx0         : out std_logic;                                        -- txdetectrx0
			hip_pipe_txelecidle0         : out std_logic;                                        -- txelecidle0
			hip_pipe_txswing0            : out std_logic;                                        -- txswing0
			hip_pipe_txmargin0           : out std_logic_vector(2 downto 0);                     -- txmargin0
			hip_pipe_txdeemph0           : out std_logic;                                        -- txdeemph0
			hip_pipe_phystatus0          : in  std_logic                     := 'X';             -- phystatus0
			hip_pipe_rxdata0             : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- rxdata0
			hip_pipe_rxdatak0            : in  std_logic                     := 'X';             -- rxdatak0
			hip_pipe_rxelecidle0         : in  std_logic                     := 'X';             -- rxelecidle0
			hip_pipe_rxstatus0           : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- rxstatus0
			hip_pipe_rxvalid0            : in  std_logic                     := 'X';             -- rxvalid0
			hip_serial_rx_in0            : in  std_logic                     := 'X';             -- rx_in0
			hip_serial_tx_out0           : out std_logic;                                        -- tx_out0
			hip_status_derr_cor_ext_rcv  : out std_logic;                                        -- derr_cor_ext_rcv
			hip_status_derr_cor_ext_rpl  : out std_logic;                                        -- derr_cor_ext_rpl
			hip_status_derr_rpl          : out std_logic;                                        -- derr_rpl
			hip_status_dlup_exit         : out std_logic;                                        -- dlup_exit
			hip_status_ltssmstate        : out std_logic_vector(4 downto 0);                     -- ltssmstate
			hip_status_ev128ns           : out std_logic;                                        -- ev128ns
			hip_status_ev1us             : out std_logic;                                        -- ev1us
			hip_status_hotrst_exit       : out std_logic;                                        -- hotrst_exit
			hip_status_int_status        : out std_logic_vector(3 downto 0);                     -- int_status
			hip_status_l2_exit           : out std_logic;                                        -- l2_exit
			hip_status_lane_act          : out std_logic_vector(3 downto 0);                     -- lane_act
			hip_status_ko_cpl_spc_header : out std_logic_vector(7 downto 0);                     -- ko_cpl_spc_header
			hip_status_ko_cpl_spc_data   : out std_logic_vector(11 downto 0);                    -- ko_cpl_spc_data
			irq_irq                      : in  std_logic_vector(15 downto 0) := (others => 'X'); -- irq
			irq_rcvr_clk_clk             : in  std_logic                     := 'X';             -- clk
			irq_rcvr_rst_reset           : in  std_logic                     := 'X';             -- reset
			m0_waitrequest               : in  std_logic                     := 'X';             -- waitrequest
			m0_readdata                  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- readdata
			m0_readdatavalid             : in  std_logic                     := 'X';             -- readdatavalid
			m0_burstcount                : out std_logic_vector(0 downto 0);                     -- burstcount
			m0_writedata                 : out std_logic_vector(63 downto 0);                    -- writedata
			m0_address                   : out std_logic_vector(15 downto 0);                    -- address
			m0_write                     : out std_logic;                                        -- write
			m0_read                      : out std_logic;                                        -- read
			m0_byteenable                : out std_logic_vector(7 downto 0);                     -- byteenable
			m0_debugaccess               : out std_logic;                                        -- debugaccess
			m0_clk_clk                   : in  std_logic                     := 'X';             -- clk
			m0_rst_reset                 : in  std_logic                     := 'X';             -- reset
			m1_waitrequest               : in  std_logic                     := 'X';             -- waitrequest
			m1_readdata                  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- readdata
			m1_readdatavalid             : in  std_logic                     := 'X';             -- readdatavalid
			m1_burstcount                : out std_logic_vector(3 downto 0);                     -- burstcount
			m1_writedata                 : out std_logic_vector(63 downto 0);                    -- writedata
			m1_address                   : out std_logic_vector(16 downto 0);                    -- address
			m1_write                     : out std_logic;                                        -- write
			m1_read                      : out std_logic;                                        -- read
			m1_byteenable                : out std_logic_vector(7 downto 0);                     -- byteenable
			m1_debugaccess               : out std_logic;                                        -- debugaccess
			m1_clk_clk                   : in  std_logic                     := 'X';             -- clk
			m1_rst_reset                 : in  std_logic                     := 'X';             -- reset
			m2_waitrequest               : in  std_logic                     := 'X';             -- waitrequest
			m2_readdata                  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- readdata
			m2_readdatavalid             : in  std_logic                     := 'X';             -- readdatavalid
			m2_burstcount                : out std_logic_vector(3 downto 0);                     -- burstcount
			m2_writedata                 : out std_logic_vector(63 downto 0);                    -- writedata
			m2_address                   : out std_logic_vector(19 downto 0);                    -- address
			m2_write                     : out std_logic;                                        -- write
			m2_read                      : out std_logic;                                        -- read
			m2_byteenable                : out std_logic_vector(7 downto 0);                     -- byteenable
			m2_debugaccess               : out std_logic;                                        -- debugaccess
			m2_clk_clk                   : in  std_logic                     := 'X';             -- clk
			m2_rst_reset                 : in  std_logic                     := 'X';             -- reset
			npor_npor                    : in  std_logic                     := 'X';             -- npor
			npor_pin_perst               : in  std_logic                     := 'X';             -- pin_perst
			nreset_status_reset_n        : out std_logic;                                        -- reset_n
			reconfig_clk_clk             : in  std_logic                     := 'X';             -- clk
			reconfig_rst_reset           : in  std_logic                     := 'X';             -- reset
			refclk_clk                   : in  std_logic                     := 'X';             -- clk
			reset_reset_n                : in  std_logic                     := 'X';             -- reset_n
			rxmirq_irq                   : in  std_logic_vector(15 downto 0) := (others => 'X'); -- irq
			rxmirq_out_irq               : out std_logic_vector(15 downto 0);                    -- irq
			txs_chipselect               : in  std_logic                     := 'X';             -- chipselect
			txs_byteenable               : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- byteenable
			txs_readdata                 : out std_logic_vector(63 downto 0);                    -- readdata
			txs_writedata                : in  std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			txs_read                     : in  std_logic                     := 'X';             -- read
			txs_write                    : in  std_logic                     := 'X';             -- write
			txs_burstcount               : in  std_logic_vector(6 downto 0)  := (others => 'X'); -- burstcount
			txs_readdatavalid            : out std_logic;                                        -- readdatavalid
			txs_waitrequest              : out std_logic;                                        -- waitrequest
			txs_address                  : in  std_logic_vector(12 downto 0) := (others => 'X')  -- address
		);
	end component pcie_avmm;

	u0 : component pcie_avmm
		port map (
			clk_clk                      => CONNECTED_TO_clk_clk,                      --           clk.clk
			coreclkout_clk               => CONNECTED_TO_coreclkout_clk,               --    coreclkout.clk
			cra_chipselect               => CONNECTED_TO_cra_chipselect,               --           cra.chipselect
			cra_address                  => CONNECTED_TO_cra_address,                  --              .address
			cra_byteenable               => CONNECTED_TO_cra_byteenable,               --              .byteenable
			cra_read                     => CONNECTED_TO_cra_read,                     --              .read
			cra_readdata                 => CONNECTED_TO_cra_readdata,                 --              .readdata
			cra_write                    => CONNECTED_TO_cra_write,                    --              .write
			cra_writedata                => CONNECTED_TO_cra_writedata,                --              .writedata
			cra_waitrequest              => CONNECTED_TO_cra_waitrequest,              --              .waitrequest
			crairq_irq                   => CONNECTED_TO_crairq_irq,                   --        crairq.irq
			hip_ctrl_test_in             => CONNECTED_TO_hip_ctrl_test_in,             --      hip_ctrl.test_in
			hip_ctrl_simu_mode_pipe      => CONNECTED_TO_hip_ctrl_simu_mode_pipe,      --              .simu_mode_pipe
			hip_pipe_sim_pipe_pclk_in    => CONNECTED_TO_hip_pipe_sim_pipe_pclk_in,    --      hip_pipe.sim_pipe_pclk_in
			hip_pipe_sim_pipe_rate       => CONNECTED_TO_hip_pipe_sim_pipe_rate,       --              .sim_pipe_rate
			hip_pipe_sim_ltssmstate      => CONNECTED_TO_hip_pipe_sim_ltssmstate,      --              .sim_ltssmstate
			hip_pipe_eidleinfersel0      => CONNECTED_TO_hip_pipe_eidleinfersel0,      --              .eidleinfersel0
			hip_pipe_powerdown0          => CONNECTED_TO_hip_pipe_powerdown0,          --              .powerdown0
			hip_pipe_rxpolarity0         => CONNECTED_TO_hip_pipe_rxpolarity0,         --              .rxpolarity0
			hip_pipe_txcompl0            => CONNECTED_TO_hip_pipe_txcompl0,            --              .txcompl0
			hip_pipe_txdata0             => CONNECTED_TO_hip_pipe_txdata0,             --              .txdata0
			hip_pipe_txdatak0            => CONNECTED_TO_hip_pipe_txdatak0,            --              .txdatak0
			hip_pipe_txdetectrx0         => CONNECTED_TO_hip_pipe_txdetectrx0,         --              .txdetectrx0
			hip_pipe_txelecidle0         => CONNECTED_TO_hip_pipe_txelecidle0,         --              .txelecidle0
			hip_pipe_txswing0            => CONNECTED_TO_hip_pipe_txswing0,            --              .txswing0
			hip_pipe_txmargin0           => CONNECTED_TO_hip_pipe_txmargin0,           --              .txmargin0
			hip_pipe_txdeemph0           => CONNECTED_TO_hip_pipe_txdeemph0,           --              .txdeemph0
			hip_pipe_phystatus0          => CONNECTED_TO_hip_pipe_phystatus0,          --              .phystatus0
			hip_pipe_rxdata0             => CONNECTED_TO_hip_pipe_rxdata0,             --              .rxdata0
			hip_pipe_rxdatak0            => CONNECTED_TO_hip_pipe_rxdatak0,            --              .rxdatak0
			hip_pipe_rxelecidle0         => CONNECTED_TO_hip_pipe_rxelecidle0,         --              .rxelecidle0
			hip_pipe_rxstatus0           => CONNECTED_TO_hip_pipe_rxstatus0,           --              .rxstatus0
			hip_pipe_rxvalid0            => CONNECTED_TO_hip_pipe_rxvalid0,            --              .rxvalid0
			hip_serial_rx_in0            => CONNECTED_TO_hip_serial_rx_in0,            --    hip_serial.rx_in0
			hip_serial_tx_out0           => CONNECTED_TO_hip_serial_tx_out0,           --              .tx_out0
			hip_status_derr_cor_ext_rcv  => CONNECTED_TO_hip_status_derr_cor_ext_rcv,  --    hip_status.derr_cor_ext_rcv
			hip_status_derr_cor_ext_rpl  => CONNECTED_TO_hip_status_derr_cor_ext_rpl,  --              .derr_cor_ext_rpl
			hip_status_derr_rpl          => CONNECTED_TO_hip_status_derr_rpl,          --              .derr_rpl
			hip_status_dlup_exit         => CONNECTED_TO_hip_status_dlup_exit,         --              .dlup_exit
			hip_status_ltssmstate        => CONNECTED_TO_hip_status_ltssmstate,        --              .ltssmstate
			hip_status_ev128ns           => CONNECTED_TO_hip_status_ev128ns,           --              .ev128ns
			hip_status_ev1us             => CONNECTED_TO_hip_status_ev1us,             --              .ev1us
			hip_status_hotrst_exit       => CONNECTED_TO_hip_status_hotrst_exit,       --              .hotrst_exit
			hip_status_int_status        => CONNECTED_TO_hip_status_int_status,        --              .int_status
			hip_status_l2_exit           => CONNECTED_TO_hip_status_l2_exit,           --              .l2_exit
			hip_status_lane_act          => CONNECTED_TO_hip_status_lane_act,          --              .lane_act
			hip_status_ko_cpl_spc_header => CONNECTED_TO_hip_status_ko_cpl_spc_header, --              .ko_cpl_spc_header
			hip_status_ko_cpl_spc_data   => CONNECTED_TO_hip_status_ko_cpl_spc_data,   --              .ko_cpl_spc_data
			irq_irq                      => CONNECTED_TO_irq_irq,                      --           irq.irq
			irq_rcvr_clk_clk             => CONNECTED_TO_irq_rcvr_clk_clk,             --  irq_rcvr_clk.clk
			irq_rcvr_rst_reset           => CONNECTED_TO_irq_rcvr_rst_reset,           --  irq_rcvr_rst.reset
			m0_waitrequest               => CONNECTED_TO_m0_waitrequest,               --            m0.waitrequest
			m0_readdata                  => CONNECTED_TO_m0_readdata,                  --              .readdata
			m0_readdatavalid             => CONNECTED_TO_m0_readdatavalid,             --              .readdatavalid
			m0_burstcount                => CONNECTED_TO_m0_burstcount,                --              .burstcount
			m0_writedata                 => CONNECTED_TO_m0_writedata,                 --              .writedata
			m0_address                   => CONNECTED_TO_m0_address,                   --              .address
			m0_write                     => CONNECTED_TO_m0_write,                     --              .write
			m0_read                      => CONNECTED_TO_m0_read,                      --              .read
			m0_byteenable                => CONNECTED_TO_m0_byteenable,                --              .byteenable
			m0_debugaccess               => CONNECTED_TO_m0_debugaccess,               --              .debugaccess
			m0_clk_clk                   => CONNECTED_TO_m0_clk_clk,                   --        m0_clk.clk
			m0_rst_reset                 => CONNECTED_TO_m0_rst_reset,                 --        m0_rst.reset
			m1_waitrequest               => CONNECTED_TO_m1_waitrequest,               --            m1.waitrequest
			m1_readdata                  => CONNECTED_TO_m1_readdata,                  --              .readdata
			m1_readdatavalid             => CONNECTED_TO_m1_readdatavalid,             --              .readdatavalid
			m1_burstcount                => CONNECTED_TO_m1_burstcount,                --              .burstcount
			m1_writedata                 => CONNECTED_TO_m1_writedata,                 --              .writedata
			m1_address                   => CONNECTED_TO_m1_address,                   --              .address
			m1_write                     => CONNECTED_TO_m1_write,                     --              .write
			m1_read                      => CONNECTED_TO_m1_read,                      --              .read
			m1_byteenable                => CONNECTED_TO_m1_byteenable,                --              .byteenable
			m1_debugaccess               => CONNECTED_TO_m1_debugaccess,               --              .debugaccess
			m1_clk_clk                   => CONNECTED_TO_m1_clk_clk,                   --        m1_clk.clk
			m1_rst_reset                 => CONNECTED_TO_m1_rst_reset,                 --        m1_rst.reset
			m2_waitrequest               => CONNECTED_TO_m2_waitrequest,               --            m2.waitrequest
			m2_readdata                  => CONNECTED_TO_m2_readdata,                  --              .readdata
			m2_readdatavalid             => CONNECTED_TO_m2_readdatavalid,             --              .readdatavalid
			m2_burstcount                => CONNECTED_TO_m2_burstcount,                --              .burstcount
			m2_writedata                 => CONNECTED_TO_m2_writedata,                 --              .writedata
			m2_address                   => CONNECTED_TO_m2_address,                   --              .address
			m2_write                     => CONNECTED_TO_m2_write,                     --              .write
			m2_read                      => CONNECTED_TO_m2_read,                      --              .read
			m2_byteenable                => CONNECTED_TO_m2_byteenable,                --              .byteenable
			m2_debugaccess               => CONNECTED_TO_m2_debugaccess,               --              .debugaccess
			m2_clk_clk                   => CONNECTED_TO_m2_clk_clk,                   --        m2_clk.clk
			m2_rst_reset                 => CONNECTED_TO_m2_rst_reset,                 --        m2_rst.reset
			npor_npor                    => CONNECTED_TO_npor_npor,                    --          npor.npor
			npor_pin_perst               => CONNECTED_TO_npor_pin_perst,               --              .pin_perst
			nreset_status_reset_n        => CONNECTED_TO_nreset_status_reset_n,        -- nreset_status.reset_n
			reconfig_clk_clk             => CONNECTED_TO_reconfig_clk_clk,             --  reconfig_clk.clk
			reconfig_rst_reset           => CONNECTED_TO_reconfig_rst_reset,           --  reconfig_rst.reset
			refclk_clk                   => CONNECTED_TO_refclk_clk,                   --        refclk.clk
			reset_reset_n                => CONNECTED_TO_reset_reset_n,                --         reset.reset_n
			rxmirq_irq                   => CONNECTED_TO_rxmirq_irq,                   --        rxmirq.irq
			rxmirq_out_irq               => CONNECTED_TO_rxmirq_out_irq,               --    rxmirq_out.irq
			txs_chipselect               => CONNECTED_TO_txs_chipselect,               --           txs.chipselect
			txs_byteenable               => CONNECTED_TO_txs_byteenable,               --              .byteenable
			txs_readdata                 => CONNECTED_TO_txs_readdata,                 --              .readdata
			txs_writedata                => CONNECTED_TO_txs_writedata,                --              .writedata
			txs_read                     => CONNECTED_TO_txs_read,                     --              .read
			txs_write                    => CONNECTED_TO_txs_write,                    --              .write
			txs_burstcount               => CONNECTED_TO_txs_burstcount,               --              .burstcount
			txs_readdatavalid            => CONNECTED_TO_txs_readdatavalid,            --              .readdatavalid
			txs_waitrequest              => CONNECTED_TO_txs_waitrequest,              --              .waitrequest
			txs_address                  => CONNECTED_TO_txs_address                   --              .address
		);

