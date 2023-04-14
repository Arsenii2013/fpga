module iv_loader
#(   
    parameter  LOADER_AW         = 16,
    parameter  LOADER_DW         = 64,
    parameter  PAGE_COUNT        = 4,
	parameter  PAGE_SIZE         = 64,
    parameter  PERIOD            = 10, // 10 Mhz
    
    parameter PCW		         = $clog2(PAGE_COUNT),
    parameter MEM_AW             = $clog2(PAGE_COUNT)  + $clog2(PAGE_SIZE) + $clog2((LOADER_DW/8))
)
(
    input  logic                 clock,
    input  logic                 reset,
    
    inout  wire                  n_config_tri,
    input  logic                 n_status_async,
    input  logic                 conf_done_async,
    inout  wire                  dclk_tri,
    inout  wire                  data_tri,
    inout  wire                  n_ce_tri,
    inout  wire  [3:0]           msel_tri,
    
    input  logic                 start,
    output logic                 error,
    output logic                 ready,
    
    input  logic [MEM_AW-1:0]    start_addr,
    avmm_if.master               loader_i,
    output logic [PCW-1:0]       page_number
);    

    enum {IDLE, WAIT_MSEL, WRITING, FINISHED} state, next_state;
    
    logic                 delay_start;
    
    logic [LOADER_DW-1:0] word;
    logic                 word_valid;
    logic                 word_writed;
    
    logic                 n_status_s;
    logic                 conf_done_s;
    logic                 n_status;
    logic                 conf_done;
    
    always_ff@(posedge clock)
        n_status_s <= n_status_async;
    always_ff@(posedge clock)
        conf_done_s <= conf_done_async;
    always_ff@(posedge clock)
        n_status <= n_status_s;
    always_ff@(posedge clock)
        conf_done <= conf_done_s;
    
    
    logic                 n_config;
    logic                 dclk;
    logic                 data;
    logic                 n_ce;
    logic [3:0]           msel;
    
    
    assign n_config_tri = (state == WRITING) ? n_config : 1'bz;
    assign dclk_tri     = (state == WRITING) ? dclk     : 1'bz;
    assign data_tri     = (state == WRITING) ? data     : 1'bz;
    assign n_ce_tri     = (state == WRITING) ? n_ce     : 1'bz;
    assign msel_tri     = (state == WAIT_MSEL || state == WRITING) ? msel     : 4'bz;
    
    assign delay_start  = (state == WRITING) && start;
    
    assign ready        = (!start && (state == IDLE)) || (state == FINISHED);
    
    logic ready_iternal;
    
    memory_reader
    #(
        .AW(LOADER_AW),
        .DW(LOADER_DW),
        .PAGE_COUNT(PAGE_COUNT),
        .PAGE_SIZE(PAGE_SIZE)
    )
    reader
    (
        clock,
        reset,
        
        start_addr,
        page_number,
        loader_i,
        
        delay_start,
       
        word,
        word_valid,
        word_writed
    );
    
    
    loader
    #(
        .DW(LOADER_DW),
        .PERIOD(PERIOD) // 10 Mhz
    )
    loader
    (
        n_config,
        n_status,
        conf_done,
        dclk,
        data,
        n_ce,
        msel,
        
        word,
        word_valid,
        word_writed,
        
        delay_start,
        error,
        ready_iternal,
        
        clock,
        reset
    );
    
    always_ff @(posedge clock, posedge reset) begin
		if(reset) begin
            state  	   <= IDLE;
		end else begin
			state      <= next_state;
		end
	end
    
    always_comb begin
		case(state) 
		IDLE: 
            next_state = (start) ? WAIT_MSEL : IDLE;
		WAIT_MSEL:
			next_state = WRITING;
		WRITING:
			next_state = (ready_iternal) ? FINISHED : WRITING;
		FINISHED:
			next_state = IDLE;
		endcase
	end

endmodule : iv_loader