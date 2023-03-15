`ifndef __DPRAM_SV__
`define __DPRAM_SV__

module dpram_m #(
    parameter PORTA_AW  = 8,
    parameter PORTA_DW  = 8,
    parameter PORTB_AW  = 8,
    parameter PORTB_DW  = 8,
    parameter INIT_FILE = "init.mif"
)
(
    input  logic                  clk,

    input  logic                  wren_a,
    input  logic [  PORTA_AW-1:0] addr_a,
    input  logic [  PORTA_DW-1:0] data_a,
    output logic [  PORTA_DW-1:0] q_a,

    input  logic                  wren_b,
    input  logic [  PORTB_AW-1:0] addr_b,
    input  logic [  PORTB_DW-1:0] data_b,
    output logic [  PORTB_DW-1:0] q_b
);

//------------------------------------------------
`timescale 1 ns / 1 ps

altsyncram	altsyncram_component 
(
    .address_a      ( addr_a ),
    .address_b      ( addr_b ),
    .clock0         ( clk    ),
    .data_a         ( data_a ),
    .data_b         ( data_b ),
    .wren_a         ( wren_a ),
    .wren_b         ( wren_b ),
    .q_a            ( q_a    ),
    .q_b            ( q_b    ),
    .aclr0          ( 1'b0   ),
    .aclr1          ( 1'b0   ),
    .addressstall_a ( 1'b0   ),
    .addressstall_b ( 1'b0   ),
    .byteena_a      ( 1'b1   ),
    .byteena_b      ( 1'b1   ),
    .clock1         ( 1'b1   ),
    .clocken0       ( 1'b1   ),
    .clocken1       ( 1'b1   ),
    .clocken2       ( 1'b1   ),
    .clocken3       ( 1'b1   ),
    .eccstatus      (        ),
    .rden_a         ( 1'b1   ),
    .rden_b         ( 1'b1   )
);

defparam
    altsyncram_component.intended_device_family             = "Cyclone V",
    altsyncram_component.lpm_type                           = "altsyncram",
    altsyncram_component.ram_block_type                     = "M10K",
    altsyncram_component.operation_mode                     = "BIDIR_DUAL_PORT",
    altsyncram_component.address_reg_b                      = "CLOCK0",
    altsyncram_component.clock_enable_input_a               = "BYPASS",
    altsyncram_component.clock_enable_input_b               = "BYPASS",
    altsyncram_component.clock_enable_output_a              = "BYPASS",
    altsyncram_component.clock_enable_output_b              = "BYPASS",
    altsyncram_component.indata_reg_b                       = "CLOCK0",
    altsyncram_component.numwords_a                         = 1 << PORTA_AW,
    altsyncram_component.numwords_b                         = 1 << PORTB_AW,
    altsyncram_component.outdata_aclr_a                     = "NONE",
    altsyncram_component.outdata_aclr_b                     = "NONE",
    altsyncram_component.outdata_reg_a                      = "UNREGISTERED",
    altsyncram_component.outdata_reg_b                      = "UNREGISTERED",
    altsyncram_component.power_up_uninitialized             = "FALSE",
    altsyncram_component.read_during_write_mode_mixed_ports = "OLD_DATA",
    altsyncram_component.read_during_write_mode_port_a      = "NEW_DATA_NO_NBE_READ",
    altsyncram_component.read_during_write_mode_port_b      = "NEW_DATA_NO_NBE_READ",
    altsyncram_component.widthad_a                          = PORTA_AW,
    altsyncram_component.widthad_b                          = PORTB_AW,
    altsyncram_component.width_a                            = PORTA_DW,
    altsyncram_component.width_b                            = PORTB_DW,
    altsyncram_component.width_byteena_a                    = 1,
    altsyncram_component.width_byteena_b                    = 1,
    altsyncram_component.wrcontrol_wraddress_reg_b          = "CLOCK0",
    altsyncram_component.init_file                          = INIT_FILE,
    altsyncram_component.init_file_layout                   = "PORT_B";

endmodule : dpram_m

`endif//__DPRAM_SV__