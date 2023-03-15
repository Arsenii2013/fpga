module page_selector // RM BYTEEN
#(
	parameter  AW         = 16,
	parameter  DW         = 64,
	parameter  MAX_BURST  = 1,
	parameter  PAGE_COUNT = 4,
	localparam PCW		  = $clog2(PAGE_COUNT)
)
(
	input logic clock,
	input logic reset,
	avmm_if.slave bus,
	
	output logic [PCW-1:0] page_number
);	
	localparam BCW 			= $clog2(MAX_BURST);
	localparam UNUSED_BITS  = $clog2(DW/8);
	
	typedef enum logic [AW - 1:0] {
		 SR     		= 8'h00,
		 CR     		= 8'h04,
		 CR_S   		= 8'h08,
		 CR_C   		= 8'h0C,
		 PAGE_NUM       = 8'h10
	} regs_t;

	enum {IDLE, READ, WRITE} state, next_state;
		
	logic [AW - UNUSED_BITS - 1:0]	reg_addr = 'h0;
	
    logic [BCW-1:0] 				cnt 	 = 'h0;
	logic [BCW-1:0] 				bus_cnt  = 'h0;
	
	logic [DW-1:0]					cr       = 'h0;
	logic [DW-1:0] 					sr 		 = 'h0;
	
	assign bus.waitrequest   = (state == IDLE);
	assign bus.readdatavalid = (state == READ);
	
	always_comb begin
		case(reg_addr) 
		SR:       bus.readdata = sr;
		CR:       bus.readdata = cr;
		PAGE_NUM: bus.readdata = page_number;
		default:  bus.readdata = 'hDEAD;
		endcase
	end
	
	always_ff @(posedge clock, posedge reset) begin
		if(reset) begin
            state  	 <= IDLE;
			cnt 	 <= 'h0;
			bus_cnt  <= 'h0;
			reg_addr <= 'h0;
		end else begin
			state    <= next_state;
		
			case(state) 
			IDLE: 
				if(bus.read || bus.write) begin
					cnt 		<= 'h0;
					bus_cnt 	<= bus.burstcount;
					reg_addr    <= bus.address;
				end
			READ: begin
				cnt 	    <= cnt+1;
				reg_addr    <= reg_addr+DW/8;
			end
			WRITE: 
				if(bus.write) begin
					case(reg_addr) 
						CR:       	cr          <= bus.writedata;
						CR_S:       cr          <= cr | bus.writedata;
						CR_C:       cr          <= cr & bus.writedata;
						PAGE_NUM: 	page_number <= bus.writedata;
						default: ;
					endcase
					cnt 		<= cnt+1;
					reg_addr    <= reg_addr+DW/8;
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