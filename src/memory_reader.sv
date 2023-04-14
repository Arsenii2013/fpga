module memory_reader
#(
    parameter AW         = 16,
    parameter DW         = 64,
    parameter PAGE_COUNT = 4,
	parameter PAGE_SIZE  = 64,
    
	parameter PCW		 = $clog2(PAGE_COUNT),
    parameter MEM_AW     = $clog2(PAGE_COUNT) + $clog2(PAGE_SIZE) + $clog2(DW/8)
)
(
    input  logic                clock,
    input  logic                reset,
    
    input  logic [MEM_AW-1:0]   start_addr,
    output logic [PCW-1:0]      page_number,
    avmm_if.master              loader_i,
    
    input  logic                start,
    
    output logic [DW-1:0]       word,
    output logic                word_valid,
    input  logic                word_writed
);  
    localparam MAX_BURST  = 1;
    localparam PAGE_ALIGN   = $clog2(PAGE_SIZE*DW/8);
	localparam UNUSED_BITS  = $clog2(DW/8);
    
    enum {IDLE, WAIT_LOADER, WAIT_MEM} state = IDLE, next_state;
    
    logic [MEM_AW-1:0] addr;

    assign loader_i.byteenable = '1;
    assign loader_i.burstcount = 'h1;
    assign loader_i.write      = 0;
    assign page_number         = addr[MEM_AW-1:PAGE_ALIGN];
    assign loader_i.address    = addr[PAGE_ALIGN-1:0];
    
    always_ff @(posedge clock, posedge reset) begin
		if(reset) begin
            state               <= IDLE;
            word_valid          <= 0;
		end else begin
            state               <= next_state;
            case(state) 
            IDLE: 
                addr            <= start_addr;
            WAIT_MEM: 
                if(loader_i.readdatavalid && !loader_i.waitrequest) begin
                    word        <= loader_i.readdata;
                    word_valid  <= 1;
                    loader_i.read <= 0;
                end else
                    loader_i.read <= 1;
                
            WAIT_LOADER:
                if(word_writed) begin
                    if(word_valid)
                        addr    <= addr + DW/'h8;
                    word_valid  <= 0;
                end
            endcase
        end
    end
    
    always_comb begin
		case(state) 
		IDLE: begin
            next_state = (start) ? WAIT_MEM : IDLE;
		end
        WAIT_MEM: begin
            if(!start)
                next_state = IDLE;
            else
                next_state = (loader_i.readdatavalid && !loader_i.waitrequest) ? WAIT_LOADER : WAIT_MEM;
		end
        WAIT_LOADER: begin
            if(!start)
                next_state = IDLE;
            else
                next_state = (word_writed) ? WAIT_MEM : WAIT_LOADER;
		end
		endcase
    end
    
endmodule
