module starter
#(
    parameter PERIOD = 10 // 10 Mhz
)
(
    output logic          n_config,
    input  logic          n_status,
    input  logic          conf_done,
    
    output logic [3:0]    msel,
    
    input  logic          start,
    output logic          error,
    output logic          ready,
    
    input  logic          clock,
    input  logic          reset
);
    localparam MSEL_cycle  = 10;
    localparam tCFG         = 500; // 500 ns
    localparam tCFG_cycle   = tCFG/PERIOD;
    localparam tCF2CK       = 230000; // 230 mks
    localparam tCF2CK_cycle = tCF2CK/PERIOD;
    localparam EDW          = $clog2((tCFG_cycle > tCF2CK_cycle) ? tCFG_cycle : tCF2CK_cycle);
    
    enum {IDLE, ERROR, WAIT_MSEL, WAIT_tCFG, WAIT_tCF2CK} state = IDLE, next_state;
    
    logic [EDW:0] elapsed = 0;
    
    assign ready        = (state == IDLE);
    assign error        = (state == ERROR);
    assign n_config     = (state != WAIT_tCFG);
    assign msel         = '0; // Cyclone IV E, 0000 - standard PS
    
    always_ff @(posedge clock, posedge reset) begin
		if(reset) begin
			state  	     <= IDLE;
            elapsed      <= 0;
		end else begin
            state        <= next_state;
            case(state) 
            WAIT_MSEL:
                elapsed  <= (next_state == WAIT_MSEL) ? elapsed + 'h1 : 'h0;//мб чуть более осмысленно
            WAIT_tCFG:
                elapsed  <= (next_state == WAIT_tCFG) ? elapsed + 'h1 : 'h0;
            WAIT_tCF2CK:
                elapsed  <= (next_state == WAIT_tCF2CK) ? elapsed + 'h1 : 'h0;
            endcase
        end
    end
    
    always_comb begin
		case(state) 
		IDLE: 
			next_state = (start) ? WAIT_MSEL : IDLE;
        ERROR:
            next_state = (start) ? WAIT_MSEL : ERROR;
            
        WAIT_MSEL:
			if(elapsed == MSEL_cycle)
                next_state = WAIT_tCFG;
            else
                next_state = WAIT_MSEL;
		WAIT_tCFG:
			if(elapsed == tCFG_cycle)
                next_state = (!conf_done && !n_status) ? WAIT_tCF2CK : ERROR;
            else
                next_state = WAIT_tCFG;
        WAIT_tCF2CK:
            if(elapsed == tCF2CK_cycle)
                next_state = (!conf_done && n_status) ? IDLE : ERROR;
            else
                next_state = WAIT_tCF2CK;
		endcase
	end

endmodule : starter
