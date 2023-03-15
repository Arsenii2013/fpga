`ifndef __PIPE_IFACE_SV__
`define __PIPE_IFACE_SV__

interface pipe_if();

logic [2:0] eidleinfersel;
logic [1:0] powerdown;
logic       rxpolarity;
logic       txcompl;
logic [7:0] txdata;
logic       txdatak;
logic       txdetectrx;
logic       txelecidle;
logic       txswing;
logic [2:0] txmargin;
logic       txdeemph;
logic       phystatus;
logic [7:0] rxdata;
logic       rxdatak;
logic       rxelecidle;
logic [2:0] rxstatus;
logic       rxvalid;

modport ep
(
    output eidleinfersel,
    output powerdown,
    output rxpolarity,
    output txcompl,
    output txdata,
    output txdatak,
    output txdetectrx,
    output txelecidle,
    output txswing,
    output txmargin,
    output txdeemph,
    input  phystatus,
    input  rxdata,
    input  rxdatak,
    input  rxelecidle,
    input  rxstatus,
    input  rxvalid
);

modport rp
(
    input  eidleinfersel,
    input  powerdown,
    input  rxpolarity,
    input  txcompl,
    input  txdata,
    input  txdatak,
    input  txdetectrx,
    input  txelecidle,
    input  txswing,
    input  txmargin,
    input  txdeemph,
    output phystatus,
    output rxdata,
    output rxdatak,
    output rxelecidle,
    output rxstatus,
    output rxvalid
);

endinterface // pipe_if

`endif // __PIPE_IFACE_SV__