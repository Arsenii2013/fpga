`timescale 1 ps / 1 ps
module altpcietb_bfm_driver_avmm #(
    parameter    TL_BFM_MODE           = 1'b0,    // 0 means full stack RP BFM mode, 1 means TL-only RP BFM (remove CFG accesses to RP internal cfg space)
    parameter    TL_BFM_RP_CAP_REG     = 32'h42,  // In TL BFM mode, pass PCIE Capabilities reg thru parameter (- there is no RP config space) {specify:  port type, cap version}
    parameter    TL_BFM_RP_DEV_CAP_REG = 32'h05,  // In TL BFM mode, pass Device Capabilities reg thru parameter (- there is no RP config space) {specify:  maxpayld size}
    parameter    APPS_TYPE_HWTCL       = 4
)
(
    input  logic clk_in,
    input  logic rstn,
    input  logic INTA,
    input  logic INTB,
    input  logic INTC,
    input  logic INTD,
    output logic dummy_out
);

//------------------------------------------------
//
//		Parameters
//
`include "altpcietb_bfm_constants.vh"
`include "altpcietb_bfm_log.vh"
`include "altpcietb_bfm_shmem.vh"
`include "altpcietb_bfm_rdwr.vh"
`include "altpcietb_bfm_configure.vh"

localparam RD_BUF_ADDR = 1 * (2 ** 16);
localparam WR_BUF_ADDR = 2 * (2 ** 16);

//------------------------------------------------
//
//		Function & Tasks
//
task pci_write(input int bar, input int addr, input int data);
    shmem_write(WR_BUF_ADDR, data, 4);
    ebfm_barwr(BAR_TABLE_POINTER, bar, addr, WR_BUF_ADDR, 4, 0);
endtask

task pci_read(input int bar, input int addr, output int data);
    ebfm_barrd_wait(BAR_TABLE_POINTER, bar, addr, RD_BUF_ADDR, 4, 0);
    data = shmem_read(RD_BUF_ADDR, 4);
endtask


task pci_write_long(input int bar, input int addr, input longint data);
    shmem_write(WR_BUF_ADDR, data, 8);
    ebfm_barwr(BAR_TABLE_POINTER, bar, addr, WR_BUF_ADDR, 8, 0);
endtask

task pci_read_long(input int bar, input int addr, output longint data);
    ebfm_barrd_wait(BAR_TABLE_POINTER, bar, addr, RD_BUF_ADDR, 8, 0);
    data = shmem_read(RD_BUF_ADDR, 8);
endtask
task automatic file_to_mem(input string f_name); 
	localparam DW 		  	 = 64;
	localparam PAGE_SIZE  = 128*8/DW; // 128 b
	localparam PAGE_COUNT = 4;
	
	int fd, status;
	int i = 0;
	fd = $fopen(f_name, "rb");
		
	for (; (i <  PAGE_SIZE*PAGE_COUNT) && !$feof(fd); i++) begin 
		logic [DW-1:0] to_write;
		for (int j=0; j < DW/8; j++) begin 
			status = $fread(to_write[j*8+:8], fd); 
		end
		pci_write(0, 8'h10, (i) / PAGE_SIZE);
		pci_write_long(2, (( i) % PAGE_SIZE) * DW/8, to_write);
	end
	
	$display("%d bytes, %d Kb, %d Mb", i*DW/8, i*DW/8/1024, i*DW/8/1024/1024);
	$fclose(fd);
endtask

task automatic verify_mem_to_file(input string f_name); 
	localparam DW 		  	 = 64;
	localparam PAGE_SIZE  = 128*8/DW; // 128 b
	localparam PAGE_COUNT = 4;
	
	int fd, status;
	int i=0;
	fd = $fopen(f_name, "rb");
	
	for (; (i <  PAGE_SIZE*PAGE_COUNT) && !$feof(fd); i++) begin 
		logic [DW-1:0] from_file;
		logic [DW-1:0] from_mem;
		for (int j=0; j <  DW/8; j++) begin 
			status = $fread(from_file[j*8+:8], fd); 
		end
		pci_write(0, 8'h10, (i) / PAGE_SIZE);
		pci_read_long(2, ((i) % PAGE_SIZE) * DW/8, from_mem);
		if(from_file != from_mem) begin
			$display("ERROR: read %d page %d word expected:%h actual:%h", i / PAGE_SIZE, i % PAGE_SIZE, from_file, from_mem);
		end
	end
	
	$display("%d bytes, %d Kb, %d Mb", i*DW/8, i*DW/8/1024, i*DW/8/1024/1024);
	$fclose(fd);
endtask

//------------------------------------------------
//
//  Logic
//
always begin : main
    
    automatic int res = 0;
	 automatic int data = 'h00000000;

    ebfm_cfg_rp_ep(
        BAR_TABLE_POINTER, // BAR Size/Address info for Endpoint
        1,                 // Bus Number for Endpoint Under Test
        1,                 // Device Number for Endpoint Under Test
        512,               // Maximum Read Request Size for Root Port
        1,                 // Display EP Config Space after setup
        0                  // Do not limit the BAR assignments to 4GB address map
    );

	$display("WRITE START");
	file_to_mem("/home/sescer/quartus_projects/big_avalon_slave/test.b");
	$display("WRITED");
	
	$display("VERIFICATION START");
	verify_mem_to_file("/home/sescer/quartus_projects/big_avalon_slave/test.b");
	$display("VERIFIED");
	 
    #30us;

    $stop();
end

endmodule // altpcietb_bfm_driver_avmm