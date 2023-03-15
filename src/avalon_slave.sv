`timescale 1ns / 1ps

module avalon_slave
#(
	parameter AW        = 16,
	parameter DW        = 64,
	parameter MAX_BURST = 1,
	parameter MEM_SIZE  = 4
)
(
	input logic clock,
	input logic reset,
	avmm_if.slave bus,
	
	output logic [3:0] leds
);	
	localparam BCW 			= $clog2(MAX_BURST);
	localparam UNUSED_BITS  = $clog2(DW/8);
	
	enum {IDLE, READ, WRITE} state, next_state;
	
	logic [DW-1:0]					  		mask;	
	logic 									reg_addr_overflow;
	logic [AW - UNUSED_BITS - 1:0]	reg_addr = 'h0;
	logic [MEM_SIZE-1:0][DW-1:0] 		memory 	= '{64'h1111111111111111, 64'h2222222222222222, 
																 64'h3333333333333333, 64'h4444444444444444};
	logic [BCW-1:0] 						cnt 		= 'h0;
	logic [BCW-1:0] 						bus_cnt 	= 'h0;
	
	genvar i;
	generate
	  for (i=0; i < DW/8; i++) begin : MASK_GEN
			assign mask[i*8 + 7:i*8] = (bus.byteenable[i]) ? 8'hFF : 8'h00;
	  end
	endgenerate
	
	assign bus.waitrequest   = (state == IDLE);
	assign bus.readdatavalid = (state == READ);
	assign bus.readdata 		 = (!reg_addr_overflow) ? memory[reg_addr] : 64'hDEADDEADDEADDEAD; 
	assign reg_addr_overflow = (reg_addr > MEM_SIZE - 1);
	assign leds 				 = memory[0][3:0];
	
	always_ff @(posedge clock, posedge reset) begin
		if(reset) begin
			state  	<= IDLE;
			cnt 	 	<= 'h0;
			bus_cnt  <= 'h0;
			reg_addr <= 'h0;
			memory 	<= '{64'h1111111111111111, 64'h2222222222222222, 
							  64'h3333333333333333, 64'h4444444444444444};
		end else begin
			state <= next_state;
		
			case(state) 
			IDLE: 
				if(bus.read || bus.write) begin
					cnt 		<= 'h0;
					bus_cnt 	<= bus.burstcount;
					reg_addr <= bus.address[AW - 1:UNUSED_BITS];
				end
			READ: begin
				cnt 		<= cnt+1;
				reg_addr <= reg_addr+1;
			end
			WRITE: 
				if(bus.write) begin // write may off
					if(!reg_addr_overflow)
						memory[reg_addr] <= (bus.writedata & mask) | (memory[reg_addr] & ~mask);
					cnt 				  <= cnt+1;
					reg_addr 		  <= reg_addr+1;
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
