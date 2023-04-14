module loader
#(
    parameter DW    = 64,
    parameter PERIOD = 10 // 10 Mhz
)
(
    output logic          n_config,
    input  logic          n_status,
    input  logic          conf_done,
    output logic          dclk,
    output logic          data,
    output logic          n_ce,
    output logic [3:0]    msel,
    
    input  logic [DW-1:0] word,
    input  logic          word_valid,
    output logic          word_writed,
    
    input  logic          start,
    output logic          error,
    output logic          ready,
    
    input  logic          clock,
    input  logic          reset
);
    localparam BITDW  = $clog2(DW);
    
    enum {ERROR, IDLE, STARTING, WRITING, WORD_WRITED, ERROR_OCCURED, FINISHED} state = IDLE, next_state = IDLE;
    
    logic [BITDW-1:0]  bit_number  = 0;
    logic starter_enable;
    logic starter_finished;
    logic starter_error;
    
    starter #(.PERIOD(PERIOD)) starter_i
    (
        n_config,
        n_status,
        conf_done,
        msel,
        n_ce,
    
        starter_enable,
        starter_error,
        starter_finished,
    
        clock,
        reset
    );
    
    assign starter_enable = start && ((state == IDLE) || (state == ERROR));
    assign data           = word[bit_number];
    assign ready          = (!start    && (state == IDLE))  || (state == FINISHED);
    assign error          = (!start    && (state == ERROR)) || (state == ERROR_OCCURED);
    assign word_writed    = (state == WORD_WRITED);
    
    always_ff @(posedge clock, posedge reset) begin
		if(reset) begin
			state      <= IDLE;
            dclk       <= 0;
            bit_number <= 0;
		end else begin
            state      <= next_state;
            case(state) 
            IDLE: begin 
                bit_number  <= 0;
                dclk <= 0; 
            end 
            ERROR: begin 
                bit_number  <= 0;
                dclk <= 0; 
            end
            STARTING: begin 
                bit_number  <= 0;
                dclk <= 0; 
            end
            WRITING: begin
                if(word_valid) begin
                    dclk <= !dclk; 
                    if(dclk)
                        bit_number <= bit_number + 'h1;
                end
            end
            WORD_WRITED: begin
                dclk        <= 0;
                bit_number  <= 0;
            end
            endcase
        end
    end

    always_comb begin
		case(state) 
		IDLE: 
            next_state = (start) ? STARTING : IDLE;
        ERROR:
            next_state = (start) ? STARTING : ERROR;
        STARTING: 
            if(starter_error)
                next_state = ERROR_OCCURED;
            else
                next_state = (starter_finished) ? WRITING : STARTING;
		WRITING:
            if(conf_done)
                next_state = FINISHED;
            else if(!n_status)
                next_state = ERROR_OCCURED;
            else
                next_state = (bit_number == DW-1) ? WORD_WRITED : WRITING;
		WORD_WRITED:
            if(conf_done)
                next_state = FINISHED;
            else if(!n_status)
                next_state = ERROR_OCCURED;
            else
                next_state = (word_valid) ? WRITING : WORD_WRITED;
        FINISHED:
            next_state = IDLE;
        ERROR_OCCURED:
            next_state = ERROR;
		endcase
    end
endmodule : loader