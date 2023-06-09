
# (C) 2001-2022 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 18.1 646 linux 2022.09.21.16:36:27

# ----------------------------------------
# ncsim - auto-generated simulation script

# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     pcie_avmm
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level shell script that compiles Altera simulation libraries
# and the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "ncsim.sh", and modify text as directed.
# 
# You can also modify the simulation flow to suit your needs. Set the
# following variables to 1 to disable their corresponding processes:
# - SKIP_FILE_COPY: skip copying ROM/RAM initialization files
# - SKIP_DEV_COM: skip compiling the Quartus EDA simulation library
# - SKIP_COM: skip compiling Quartus-generated IP simulation files
# - SKIP_ELAB and SKIP_SIM: skip elaboration and simulation
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator. In this case, you must also copy the generated files
# # "cds.lib" and "hdl.var" - plus the directory "cds_libs" if generated - 
# # into the location from which you launch the simulator, or incorporate
# # into any existing library setup.
# #
# # Run Quartus-generated IP simulation script once to compile Quartus EDA
# # simulation libraries and Quartus-generated IP simulation files, and copy
# # any ROM/RAM initialization files to the simulation directory.
# # - If necessary, specify any compilation options:
# #   USER_DEFINED_COMPILE_OPTIONS
# #   USER_DEFINED_VHDL_COMPILE_OPTIONS applied to vhdl compiler
# #   USER_DEFINED_VERILOG_COMPILE_OPTIONS applied to verilog compiler
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_ELAB=1 \
# SKIP_SIM=1 \
# USER_DEFINED_COMPILE_OPTIONS=<compilation options for your design> \
# USER_DEFINED_VHDL_COMPILE_OPTIONS=<VHDL compilation options for your design> \
# USER_DEFINED_VERILOG_COMPILE_OPTIONS=<Verilog compilation options for your design> \
# QSYS_SIMDIR=<script generation output directory>
# #
# # Compile all design files and testbench files, including the top level.
# # (These are all the files required for simulation other than the files
# # compiled by the IP script)
# #
# ncvlog <compilation options> <design and testbench files>
# #
# # TOP_LEVEL_NAME is used in this script to set the top-level simulation or
# # testbench module/entity name.
# #
# # Run the IP script again to elaborate and simulate the top level:
# # - Specify TOP_LEVEL_NAME and USER_DEFINED_ELAB_OPTIONS.
# # - Override the default USER_DEFINED_SIM_OPTIONS. For example, to run
# #   until $finish(), set to an empty string: USER_DEFINED_SIM_OPTIONS="".
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_FILE_COPY=1 \
# SKIP_DEV_COM=1 \
# SKIP_COM=1 \
# TOP_LEVEL_NAME=<simulation top> \
# USER_DEFINED_ELAB_OPTIONS=<elaboration options for your design> \
# USER_DEFINED_SIM_OPTIONS=<simulation options for your design>
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If pcie_avmm is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 18.1 646 linux 2022.09.21.16:36:27
# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="pcie_avmm"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="/opt/cad/intel/quartus18.1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/error_adapter_0/
mkdir -p ./libraries/router/
mkdir -p ./libraries/avalon_st_adapter/
mkdir -p ./libraries/async_fifo/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/mm_clock_crossing_bridge_0_s0_burst_adapter/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/mm_clock_crossing_bridge_0_s0_agent_rsp_fifo/
mkdir -p ./libraries/mm_clock_crossing_bridge_0_s0_agent/
mkdir -p ./libraries/pcie_cv_hip_avmm_0_Rxm_BAR0_agent/
mkdir -p ./libraries/mm_clock_crossing_bridge_0_s0_translator/
mkdir -p ./libraries/pcie_cv_hip_avmm_0_Rxm_BAR0_translator/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/mm_interconnect_2/
mkdir -p ./libraries/mm_interconnect_1/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/pcie_cv_hip_avmm_0/
mkdir -p ./libraries/mm_clock_crossing_bridge_0/
mkdir -p ./libraries/irq_clock_crosser_0/
mkdir -p ./libraries/alt_xcvr_reconfig_0/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cyclonev_ver/
mkdir -p ./libraries/cyclonev_hssi_ver/
mkdir -p ./libraries/cyclonev_pcie_hip_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                      -work altera_ver           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                               -work lpm_ver              
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                  -work sgate_ver            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                              -work altera_mf_ver        
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                          -work altera_lnsim_ver     
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                         -work cyclonev_ver         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                    -work cyclonev_hssi_ver    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"                -work cyclonev_pcie_hip_ver
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"             -work error_adapter_0                              -cdslib ./cds_libs/error_adapter_0.cds.lib                             
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_2_router.sv"                                        -work router                                       -cdslib ./cds_libs/router.cds.lib                                      
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_1_router.sv"                                        -work router                                       -cdslib ./cds_libs/router.cds.lib                                      
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_avalon_st_adapter.v"                              -work avalon_st_adapter                            -cdslib ./cds_libs/avalon_st_adapter.cds.lib                           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_dc_fifo.v"                                                      -work async_fifo                                   -cdslib ./cds_libs/async_fifo.cds.lib                                  
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_dcfifo_synchronizer_bundle.v"                                          -work async_fifo                                   -cdslib ./cds_libs/async_fifo.cds.lib                                  
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                              -work async_fifo                                   -cdslib ./cds_libs/async_fifo.cds.lib                                  
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_rsp_mux.sv"                                       -work rsp_mux                                      -cdslib ./cds_libs/rsp_mux.cds.lib                                     
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                  -work rsp_mux                                      -cdslib ./cds_libs/rsp_mux.cds.lib                                     
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_rsp_demux.sv"                                     -work rsp_demux                                    -cdslib ./cds_libs/rsp_demux.cds.lib                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_cmd_mux.sv"                                       -work cmd_mux                                      -cdslib ./cds_libs/cmd_mux.cds.lib                                     
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                  -work cmd_mux                                      -cdslib ./cds_libs/cmd_mux.cds.lib                                     
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_cmd_demux.sv"                                     -work cmd_demux                                    -cdslib ./cds_libs/cmd_demux.cds.lib                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                               -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                        -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                          -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                           -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                               -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                               -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                            -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                           -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                           -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                             -work mm_clock_crossing_bridge_0_s0_burst_adapter  -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_burst_adapter.cds.lib 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_router_001.sv"                                    -work router_001                                   -cdslib ./cds_libs/router_001.cds.lib                                  
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0_router.sv"                                        -work router                                       -cdslib ./cds_libs/router.cds.lib                                      
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                      -work mm_clock_crossing_bridge_0_s0_agent_rsp_fifo -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_agent_rsp_fifo.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                                 -work mm_clock_crossing_bridge_0_s0_agent          -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_agent.cds.lib         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                          -work mm_clock_crossing_bridge_0_s0_agent          -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_agent.cds.lib         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                                -work pcie_cv_hip_avmm_0_Rxm_BAR0_agent            -cdslib ./cds_libs/pcie_cv_hip_avmm_0_Rxm_BAR0_agent.cds.lib           
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                            -work mm_clock_crossing_bridge_0_s0_translator     -cdslib ./cds_libs/mm_clock_crossing_bridge_0_s0_translator.cds.lib    
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                           -work pcie_cv_hip_avmm_0_Rxm_BAR0_translator       -cdslib ./cds_libs/pcie_cv_hip_avmm_0_Rxm_BAR0_translator.cds.lib      
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                    -work rst_controller                               -cdslib ./cds_libs/rst_controller.cds.lib                              
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                  -work rst_controller                               -cdslib ./cds_libs/rst_controller.cds.lib                              
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_2.v"                                                -work mm_interconnect_2                            -cdslib ./cds_libs/mm_interconnect_2.cds.lib                           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_1.v"                                                -work mm_interconnect_1                            -cdslib ./cds_libs/mm_interconnect_1.cds.lib                           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/pcie_avmm_mm_interconnect_0.v"                                                -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_a2p_addrtrans.v"                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_a2p_fixtrans.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_a2p_vartrans.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_control_register.v"                              -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_cr_avalon.v"                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_cr_interrupt.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_cr_rp.v"                                         -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_cfg_status.v"                                    -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_cr_mailbox.v"                                    -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_p2a_addrtrans.v"                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_reg_fifo.v"                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_rx.v"                                            -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_rx_cntrl.v"                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_rx_resp.v"                                       -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_tx.v"                                            -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_tx_cntrl.v"                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_txavl_cntrl.v"                                   -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_stif_txresp_cntrl.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_stif/altpciexpav_clksync.v"                                            -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_a2p_addrtrans.v"                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_a2p_fixtrans.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_a2p_vartrans.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_clksync.v"                                       -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_control_register.v"                              -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_cr_avalon.v"                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_cr_interrupt.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_cr_rp.v"                                         -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_cfg_status.v"                                    -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_cr_mailbox.v"                                    -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_p2a_addrtrans.v"                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_rx.v"                                            -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_rx_cntrl.v"                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_fifo.v"                                          -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_rxm_adapter.v"                                   -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_rx_resp.v"                                       -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_tx.v"                                            -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_tx_cntrl.v"                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_txavl_cntrl.v"                                   -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_txresp_cntrl.v"                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_mm_128/altpciexpav128_underflow_adapter.v"                             -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/avalon_lite/altpciexpav_lite_app.v"                                           -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpcie_cv_hip_avmm_hwtcl.v"                                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpciexpav_stif_app.v"                                                       -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpciexpav128_app.v"                                                         -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpcie_cv_hip_ast_hwtcl.v"                                                   -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpcie_av_hip_128bit_atom.v"                                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpcie_av_hip_ast_hwtcl.v"                                                   -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpcie_rs_hip.v"                                                             -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpcie_rs_serdes.v"                                                          -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altpcierd_hip_rs.v"                                                           -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_xcvr_functions.sv"                                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/sv_reconfig_bundle_to_xcvr.sv"                                                -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/sv_reconfig_bundle_to_ip.sv"                                                  -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/sv_reconfig_bundle_merger.sv"                                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_h.sv"                                                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_avmm_csr.sv"                                                          -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_tx_pma_ch.sv"                                                              -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_tx_pma.sv"                                                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_rx_pma.sv"                                                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_pma.sv"                                                                    -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_pcs_ch.sv"                                                                 -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_pcs.sv"                                                                    -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_avmm.sv"                                                              -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_native.sv"                                                            -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_plls.sv"                                                              -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_data_adapter.sv"                                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_reconfig_bundle_to_basic.sv"                                               -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_reconfig_bundle_to_xcvr.sv"                                                -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_8g_rx_pcs_rbc.sv"                                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_8g_tx_pcs_rbc.sv"                                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_common_pcs_pma_interface_rbc.sv"                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_common_pld_pcs_interface_rbc.sv"                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_pipe_gen1_2_rbc.sv"                                                   -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_rx_pcs_pma_interface_rbc.sv"                                          -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_rx_pld_pcs_interface_rbc.sv"                                          -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_tx_pcs_pma_interface_rbc.sv"                                          -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_hssi_tx_pld_pcs_interface_rbc.sv"                                          -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_reset_ctrl_lego.sv"                                                       -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_reset_ctrl_tgx_cdrauto.sv"                                                -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_resync.sv"                                                           -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_csr_common_h.sv"                                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_csr_common.sv"                                                       -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_csr_pcs8g_h.sv"                                                      -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_csr_pcs8g.sv"                                                        -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_csr_selector.sv"                                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_mgmt2dec.sv"                                                         -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_wait_generate.v"                                                       -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_emsip_adapter.sv"                                                     -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_pipe_native_hip.sv"                                                   -work pcie_cv_hip_avmm_0                           -cdslib ./cds_libs/pcie_cv_hip_avmm_0.cds.lib                          
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_mm_clock_crossing_bridge.v"                                     -work mm_clock_crossing_bridge_0                   -cdslib ./cds_libs/mm_clock_crossing_bridge_0.cds.lib                  
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_dc_fifo.v"                                                      -work mm_clock_crossing_bridge_0                   -cdslib ./cds_libs/mm_clock_crossing_bridge_0.cds.lib                  
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_dcfifo_synchronizer_bundle.v"                                          -work mm_clock_crossing_bridge_0                   -cdslib ./cds_libs/mm_clock_crossing_bridge_0.cds.lib                  
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                              -work mm_clock_crossing_bridge_0                   -cdslib ./cds_libs/mm_clock_crossing_bridge_0.cds.lib                  
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_irq_clock_crosser.sv"                                                  -work irq_clock_crosser_0                          -cdslib ./cds_libs/irq_clock_crosser_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_xcvr_functions.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_h.sv"                                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_resync.sv"                                                           -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_h.sv"                                                       -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig.sv"                                                         -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cal_seq.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xreconf_cif.sv"                                                           -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xreconf_uif.sv"                                                           -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xreconf_basic_acq.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_analog.sv"                                                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_analog_av.sv"                                               -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xreconf_analog_datactrl_av.sv"                                            -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xreconf_analog_rmw_av.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xreconf_analog_ctrlsm.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_offset_cancellation.sv"                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_offset_cancellation_av.sv"                                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_eyemon.sv"                                                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_dfe.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_adce.sv"                                                    -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_dcd.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_dcd_av.sv"                                                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_dcd_cal_av.sv"                                              -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_dcd_control_av.sv"                                          -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_mif.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_reconfig_mif.sv"                                                      -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_reconfig_mif_ctrl.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_reconfig_mif_avmm.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_pll.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_reconfig_pll.sv"                                                      -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_reconfig_pll_ctrl.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_soc.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_ram.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_direct.sv"                                                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_arbiter_acq.sv"                                                           -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_basic.sv"                                                   -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xrbasic_l2p_addr.sv"                                                       -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xrbasic_l2p_ch.sv"                                                         -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xrbasic_l2p_rom.sv"                                                        -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xrbasic_lif_csr.sv"                                                        -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xrbasic_lif.sv"                                                            -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_xcvr_reconfig_basic.sv"                                                    -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_arbiter.sv"                                                          -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_m2s.sv"                                                              -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_wait_generate.v"                                                       -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_csr_selector.sv"                                                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/sv_reconfig_bundle_to_basic.sv"                                               -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_reconfig_bundle_to_basic.sv"                                               -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/av_reconfig_bundle_to_xcvr.sv"                                                -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu.v"                                                      -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_reconfig_cpu.v"                                         -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_reconfig_cpu_test_bench.v"                              -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0.v"                                    -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_irq_mapper.sv"                                          -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                    -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                           -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                            -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                                -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                                 -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                          -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                      -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_router.sv"                            -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_001.sv"                        -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_002.sv"                        -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_router_003.sv"                        -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_demux.sv"                         -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_demux_001.sv"                     -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_mux.sv"                           -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_cmd_mux_001.sv"                       -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_rsp_mux.sv"                           -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_rsp_mux_001.sv"                       -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_avalon_st_adapter.v"                  -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_xcvr_reconfig_cpu_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv" -work alt_xcvr_reconfig_0                          -cdslib ./cds_libs/alt_xcvr_reconfig_0.cds.lib                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/pcie_avmm.v"                                                                                                                                                                                                       
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  export GENERIC_PARAM_COMPAT_CHECK=1
  ncelab -access +w+r+c -namemap_mixgen $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi
