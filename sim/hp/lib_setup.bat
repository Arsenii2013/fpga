vlib                        lib\altera_ver
vlib                        lib\lpm_ver
vlib                        lib\sgate_ver
vlib                        lib\altera_mf_ver
vlib                        lib\altera_lnsim_ver
vlib                        lib\cyclonev_ver
vlib                        lib\cyclonev_hssi_ver
vlib                        lib\cyclonev_pcie_hip_ver
vlib                        lib\stratixiv_ver
vlib                        lib\stratixiv_hssi_ver
vlib                        lib\stratixiv_pcie_hip_ver

vmap altera_ver             lib\altera_ver
vmap lpm_ver                lib\lpm_ver
vmap sgate_ver              lib\sgate_ver
vmap altera_mf_ver          lib\altera_mf_ver
vmap altera_lnsim_ver       lib\altera_lnsim_ver
vmap cyclonev_ver           lib\cyclonev_ver
vmap cyclonev_hssi_ver      lib\cyclonev_hssi_ver
vmap cyclonev_pcie_hip_ver  lib\cyclonev_pcie_hip_ver
vmap stratixiv_ver          lib\stratixiv_ver
vmap stratixiv_hssi_ver     lib\stratixiv_hssi_ver
vmap stratixiv_pcie_hip_ver lib\stratixiv_pcie_hip_ver

vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\altera_primitives.v                     -work altera_ver
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\220model.v                              -work lpm_ver               
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\sgate.v                                 -work sgate_ver             
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\altera_mf.v                             -work altera_mf_ver         
vlog -sv %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\altera_lnsim.sv                         -work altera_lnsim_ver      
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\mentor\cyclonev_atoms_ncrypt.v          -work cyclonev_ver
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\mentor\cyclonev_hmi_atoms_ncrypt.v      -work cyclonev_ver
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\cyclonev_atoms.v                        -work cyclonev_ver          
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\mentor\cyclonev_hssi_atoms_ncrypt.v     -work cyclonev_hssi_ver
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\cyclonev_hssi_atoms.v                   -work cyclonev_hssi_ver     
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\mentor\cyclonev_pcie_hip_atoms_ncrypt.v -work cyclonev_pcie_hip_ver 
vlog     %QUARTUS_INSTALL_DIR%\quartus\eda\sim_lib\cyclonev_pcie_hip_atoms.v               -work cyclonev_pcie_hip_ver 
vlog     %QUARTUS_INSTALL_DIR%\modelsim_ase\altera\verilog\src\stratixiv_hssi_atoms.v      -work stratixiv_hssi_ver    
vlog     %QUARTUS_INSTALL_DIR%\modelsim_ase\altera\verilog\src\stratixiv_pcie_hip_atoms.v  -work stratixiv_pcie_hip_ver
vlog     %QUARTUS_INSTALL_DIR%\modelsim_ase\altera\verilog\src\stratixiv_atoms.v           -work stratixiv_ver         

vlib lib\wlib
vmap wlib lib\wlib
