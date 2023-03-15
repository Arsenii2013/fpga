set_time_format -unit ns -decimal_places 3

#----------------------------------------------------------------------------------------
#
#   input clocks
#
create_clock -period "100 MHz" -name sysclk     [get_ports sysclk]
create_clock -period "100 MHz" -name pci_refclk [get_ports pci_refclk]

#----------------------------------------------------------------------------------------
#
#   generated clocks
#
derive_pll_clocks
derive_clock_uncertainty

#----------------------------------------------------------------------------------------
#
#   slow signals
#
set_false_path -from [ get_ports pci_perst_n  ]
set_false_path -to   [ get_ports led[*]       ]