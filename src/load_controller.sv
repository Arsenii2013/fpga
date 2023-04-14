module load_controller
#(
	parameter  AW         = 16,
	parameter  DW         = 64,
	parameter  MAX_BURST  = 1,
    parameter  PAGE_COUNT = 4,
	parameter  PAGE_SIZE  = 64,
    
    parameter  MEM_AW     = $clog2(PAGE_COUNT) + $clog2(PAGE_SIZE) + $clog2(DW/8) + 1
 )
(
	input logic clock,
	input logic reset,
	avmm_if.slave bus,
	
    
    output logic [AW-1:0]   start_addr,
    
    output logic  start,
    input  logic  error,
    input  logic  ready,
    
    input logic             n_config,
    input logic             n_status,
    input logic             conf_done,
    input logic             dclk,
    input logic             data,
    input logic [      1:0] msel,
    input logic             n_ce
);	
	localparam BCW 			= $clog2(MAX_BURST);
	
    typedef logic [AW - 1:0] addr_t;
	typedef enum addr_t {
		 SR     		= addr_t'(8'h00),
		 CR     		= addr_t'(8'h04),
		 CR_S   		= addr_t'(8'h08),
		 CR_C   		= addr_t'(8'h0C),
		 START_ADDR     = addr_t'(8'h10),
		 LOADER_STATUS  = addr_t'(8'h14)
	} regs_t;

	enum {IDLE, READ, WRITE} state, next_state;
		
	logic [AW - 1:0]                reg_addr = '0;
	
    logic [BCW-1:0] 				cnt 	 = '0;
	logic [BCW-1:0] 				bus_cnt  = '0;
	
	logic [DW-1:0]					cr       = '0;
	logic [DW-1:0] 					sr 		 ;
	logic [DW-1:0] 					ls 		 ;
    initial sr [DW-1:3] 		             = '0;
    
    assign ls[0] = n_config;
    assign ls[1] = n_status;
    assign ls[2] = conf_done;
    assign ls[3] = dclk;
    assign ls[4] = data;
    assign ls[5] = msel[0];
    assign ls[6] = msel[1];
    assign ls[7] = n_ce;

    assign start = cr[0];
    assign sr[0] = cr[0];
    assign sr[1] = ready;
    assign sr[2] = error;
    
    assign bus.waitrequest   = (state == IDLE);
	assign bus.readdatavalid = (state == READ);
    
	always_comb begin
		case(reg_addr) 
		SR:         bus.readdata = sr;
		CR:         bus.readdata = cr;
		START_ADDR: bus.readdata = start_addr;
        LOADER_STATUS: bus.readdata = ls;
		default:    bus.readdata = 'hDEAD;
		endcase
	end
	
	always_ff @(posedge clock, posedge reset) begin
		if(reset) begin
            state  	   <= IDLE;
			cnt 	   <= '0;
			bus_cnt    <= '0;
			reg_addr   <= '0;
            cr         <= '0;
            //sr         <= '0;
            start_addr <= '0;
		end else begin
			state    <= next_state;
            
            if(error || ready)
                cr[0] <= 0;
		
			case(state) 
			IDLE: 
				if(bus.read || bus.write) begin
					cnt 		<= '0;
					bus_cnt 	<= bus.burstcount;
					reg_addr    <= bus.address;
				end
			READ: begin
				cnt 	    <= cnt+'h1;
				reg_addr    <= reg_addr+DW/'h8;
			end
			WRITE: 
				if(bus.write) begin
					case(reg_addr) 
						CR:       	cr          <= bus.writedata;
						CR_S:       cr          <= cr | bus.writedata;
						CR_C:       cr          <= cr & bus.writedata;
						START_ADDR: start_addr  <= bus.writedata;
						default: ;
					endcase
					cnt 		<= cnt+'h1;
					reg_addr    <= reg_addr+DW/'h8;
				end
			endcase
		end
	end
	
	always_comb begin
		case(state) 
		IDLE: begin
			if(bus.write || bus.read)
				next_state = (bus.write) ? WRITE : READ;
			else 
				next_state = IDLE;
		end
		READ:
			next_state = (cnt == bus_cnt - 1) ? IDLE : READ;
		WRITE:
			next_state = (cnt == bus_cnt - 1) ? IDLE : WRITE;
		endcase
	end
	
endmodule
