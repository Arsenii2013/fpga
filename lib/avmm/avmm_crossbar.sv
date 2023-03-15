`ifndef __AVMM_CROSSBAR_SV__
`define __AVMM_CROSSBAR_SV__

module avmm_crossbar_m
#(
    parameter N         = 2,
    parameter AW        = 16,
    parameter BAW       = 6,
    parameter DW        = 32,
    parameter MAX_BURST = 1
)
(
    input logic    clk,
    input logic    rst,

    avmm_if.slave  m,
    avmm_if.master s[N]
);

//------------------------------------------------
`timescale 1ns / 1ps

//------------------------------------------------
//
//      Types
//
typedef logic [            BAW-1:0] base_addr_t;
typedef logic [      $clog2(N)-1:0] slave_id_t;
typedef logic [$clog2(MAX_BURST):0] count_t;
typedef logic [             DW-1:0] data_t;

typedef enum {
    IDLE, 
    WRITE, 
    READ
} state_t;

//------------------------------------------------
//
//      Objects
//
state_t       state = IDLE, next;

slave_id_t    id;
base_addr_t   base;
logic         avalid = 1;
logic         out_of_range;
count_t       count;
count_t       cnt = '0;

logic [N-1:0] write;
logic [N-1:0] read;
logic [N-1:0] ready;
logic [N-1:0] valid;
data_t        rdata[N];

//------------------------------------------------
//
//      Logic
//
genvar i;
generate
    for (i=0; i<N; i++) begin : avmm_mux
        assign s[i].write      = write[i];
        assign s[i].read       = read[i];
        assign s[i].address    = m.address[AW-BAW-1:0];
        assign s[i].burstcount = m.burstcount;
        assign s[i].byteenable = m.byteenable;
        assign s[i].writedata  = m.writedata;

        assign ready[i]        = ~s[i].waitrequest;
        assign valid[i]        =  s[i].readdatavalid;
        assign rdata[i]        =  s[i].readdata;
    end
endgenerate

//------------------------------------------------
assign base         = base_addr_t'(m.address[AW-1:AW-BAW]);
assign out_of_range = base > base_addr_t'(N-1);

always_ff @(posedge clk) begin
    if (rst) begin
        state  <= IDLE;
        cnt    <= '0;
        avalid <= 1;
    end
    else begin
        state <= next;
        case (state)
            IDLE: begin
                cnt    <= '0;
                avalid <= 1;
                count  <= m.burstcount;
                if (m.write || m.read) begin
                    if (!out_of_range) id     <= slave_id_t'(base);
                    else               avalid <= 0;
                end
            end
            WRITE: if (m.write & ~m.waitrequest) cnt <= cnt + count_t'(1);
            READ:  if (m.readdatavalid)          cnt <= cnt + count_t'(1);
        endcase
    end
end

always_comb begin
    if (rst) begin
        next = IDLE;
    end
    else begin
        case (state)
            IDLE: begin
                if (m.write | m.read)         next = m.write ? WRITE : READ;
                else                          next = IDLE;
            end
            WRITE: begin
                if (m.write & ~m.waitrequest) next = (cnt == count - count_t'(1)) ? IDLE : WRITE;
                else                          next = WRITE;
            end
            READ: begin
                if (m.readdatavalid)          next = (cnt == count - count_t'(1)) ? IDLE : READ;
                else                          next = READ;
            end
        endcase
    end
end

always_comb begin
    m.waitrequest   = 1;
    m.readdatavalid = 0;
    m.readdata      = '0;
    
    for (int i=0; i<N; i++) begin
        write[i] = 0;
        read[i]  = 0;
    end
    
    if (state != IDLE && avalid) begin
        write[id]       =  m.write;
        read[id]        =  m.read;
        m.waitrequest   = ~ready[id];
        m.readdatavalid =  valid[id];
        m.readdata      =  rdata[id];
    end

    if (state != IDLE && !avalid) begin
        m.waitrequest   = 0;
        m.readdatavalid = state == READ;
        m.readdata      = 32'hDEAD_DEAD;
    end
end

//------------------------------------------------
endmodule : avmm_crossbar_m

`endif // __AVMM_CROSSBAR_SV__