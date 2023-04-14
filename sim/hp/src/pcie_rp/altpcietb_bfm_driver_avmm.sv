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


localparam PAGE_SELECTOR_OFFS   = 'h3800;
localparam LOAD_CONTROLLER_OFFS = 'h3C00;
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
	localparam DW 		  = 64;
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
        
		pci_write(0, PAGE_SELECTOR_OFFS + 64'h10, i / PAGE_SIZE);
		pci_write_long(2, (i % PAGE_SIZE) * DW/8, to_write);
	end
	
	$display("%d bytes, %d Kb, %d Mb", i*DW/8, i*DW/8/1024, i*DW/8/1024/1024);
	$fclose(fd);
endtask

task automatic verify_mem_to_file(input string f_name); 
	localparam DW 		  = 64;
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
            //status = $fseek(fd, 0, 0);
		end
        
		pci_write(0, PAGE_SELECTOR_OFFS + 64'h10, i / PAGE_SIZE);
		pci_read_long(2, (i % PAGE_SIZE) * DW/8, from_mem);
        
		if(from_file != from_mem) begin
			$display("ERROR: read %d page %d word expected:%h actual:%h", i / PAGE_SIZE, i % PAGE_SIZE, from_file, from_mem);
		end
	end
	
	$display("%d bytes, %d Kb, %d Mb", i*DW/8, i*DW/8/1024, i*DW/8/1024/1024);
	$fclose(fd);
endtask

function copy_mem();     
    hp_tb.hp_inst.hps_wrapper.loader_mem.pages <= hp_tb.hp_inst.hps_wrapper.bar_mem.pages; 
endfunction

task automatic iv_start_cfg(); 
    localparam tCF2CD  = 300; // 300 ns to conf_done low
    localparam tCF2ST0 = tCF2CD; // 300 ns to n_status low
    localparam tSTATUS = 100000; // 100 mks n_status low width
    localparam tCF2ST1 = 100000; // 100 mks to to n_status high
    localparam tCF2CK  = 230000; // 100 mks to to n_status high
    
    @(negedge hp_tb.n_config)
    #tCF2CD;
    hp_tb.n_status  <= 0;
    hp_tb.conf_done <= 0;
    @(posedge hp_tb.n_config)
    #tCF2ST1;
    hp_tb.n_status  <= 1;
    #(tCF2CK - tCF2ST1);
endtask

task automatic iv_end_cfg(); 
    hp_tb.conf_done <= 1;
endtask

task automatic iv_error_cfg(); 
    hp_tb.conf_done <= 0;
    
    hp_tb.n_status <= 0;
    @(negedge hp_tb.sysclk)
    @(negedge hp_tb.sysclk)
    @(negedge hp_tb.sysclk)
    hp_tb.n_status <= 1;
endtask

task automatic iv_recieve_bytes(input int cnt, input logic [7:0] data_expected [512], output int error); 
    error = 0;
    for (int i=0; i < cnt && !error; i++) begin 
        hp_tb.data_e <= data_expected[i][0];
        for (int j=0; j < 8 && !error; j++) begin 
            @(posedge hp_tb.dclk)
            if(hp_tb.data != data_expected[i][j]) begin
                $display("ERROR read byte %d(%x) bit %d: actual %h expected %h", i, data_expected[i], j, hp_tb.data, data_expected[i][j]);
                error = 1;
            end
            @(negedge hp_tb.dclk)    
            hp_tb.data_e <= data_expected[i][j+1];
        end
    end
endtask

task automatic verify_load(input string f_name); 	
	localparam DW 		  = 64;
    logic [7:0] data_expected [512];
	int fd, status;
	int i=0;
    int error;
	fd = $fopen(f_name, "rb");
	
	for (; (i < 512) && !$feof(fd); i++) begin
        status = $fread(data_expected[i], fd); 
        status = $fseek(fd, 0, 0);
    end
    
    @(posedge hp_tb.sysclk)
    iv_start_cfg(); 
    iv_recieve_bytes(i, data_expected, error);
    if(error)
        iv_error_cfg(); 
    else
        iv_end_cfg(); 
	$fclose(fd);
	$display("%d bytes, %d Kb, %d Mb", i*DW/8, i*DW/8/1024, i*DW/8/1024/1024);
endtask

//------------------------------------------------
//
//  Logic
//
always begin : main
    
    automatic int sr = 0;

    ebfm_cfg_rp_ep(
        BAR_TABLE_POINTER, // BAR Size/Address info for Endpoint
        1,                 // Bus Number for Endpoint Under Test
        1,                 // Device Number for Endpoint Under Test
        512,               // Maximum Read Request Size for Root Port
        1,                 // Display EP Config Space after setup
        0                  // Do not limit the BAR assignments to 4GB address map
    );

	$display("WRITE START");
	file_to_mem("/home/sescer/quartus_projects/fpga/sim/hp/test.b");
	$display("WRITED");
	
	$display("VERIFICATION START");
	verify_mem_to_file("/home/sescer/quartus_projects/fpga/sim/hp/test.b");
	$display("VERIFIED");
	 
    $display("COPY START");
	copy_mem(); 
	$display("COPYED");
    
    hp_tb.n_status     <= 1;
    hp_tb.conf_done    <= 1;
    
    pci_read(0, LOAD_CONTROLLER_OFFS + 64'h00, sr);
    $display("loader sr: ready(%d), error(%d), start(%d)", (sr>>1) & 'h1, (sr>>2) & 'h1, sr & 'h1);
    pci_write(0, LOAD_CONTROLLER_OFFS + 64'h04, 'h01);
    
    $display("LOAD START");
	verify_load("/home/sescer/quartus_projects/fpga/sim/hp/test.b");
	$display("LOADED");
    
    @(negedge hp_tb.sysclk)
    @(negedge hp_tb.sysclk)
    pci_read(0, LOAD_CONTROLLER_OFFS + 64'h00, sr);
    $display("loader sr: ready(%d), error(%d), start(%d)", (sr>>1) & 'h1, (sr>>2) & 'h1, sr & 'h1);
    pci_write(0, LOAD_CONTROLLER_OFFS + 64'h04, 'h01);
    
    $display("ERROR TEST START");
	verify_load("/home/sescer/quartus_projects/fpga/sim/hp/zero.b");
	$display("ERROR TESTED");
    
    @(negedge hp_tb.sysclk)
    @(negedge hp_tb.sysclk)
    pci_read(0, LOAD_CONTROLLER_OFFS + 64'h00, sr);
    $display("loader sr: ready(%d), error(%d), start(%d)", (sr>>1) & 'h1, (sr>>2) & 'h1, sr & 'h1);
    pci_write(0, LOAD_CONTROLLER_OFFS + 64'h04, 'h01);
    
    $display("LOAD START");
	verify_load("/home/sescer/quartus_projects/fpga/sim/hp/test.b");
	$display("LOADED");
    
    @(negedge hp_tb.sysclk)
    @(negedge hp_tb.sysclk)
    pci_read(0, LOAD_CONTROLLER_OFFS + 64'h00, sr);
    $display("loader sr: ready(%d), error(%d), start(%d)", (sr>>1) & 'h1, (sr>>2) & 'h1, sr & 'h1);
    
    #30us;

    $stop();
end

endmodule // altpcietb_bfm_driver_avmm