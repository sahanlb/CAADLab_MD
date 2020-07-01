////////////////////////////////////////////////////////////
// Same as filter buffer, but renamed for clarification
////////////////////////////////////////////////////////////

module force_output_buffer
#(
	parameter FORCE_BUFFER_WIDTH = 32,
	parameter FORCE_BUFFER_DEPTH = 32,
	parameter FORCE_BUFFER_ADDR_WIDTH = 5					// log(FORCE_BUFFER_DEPTH) / log 2
)
(
    clock,
    data,
    rdreq,
    wrreq,
    empty,
    full,
    q,
    usedw
); 

    input    clock;
    input  [FORCE_BUFFER_WIDTH-1:0]  data;
    input    rdreq;
    input    wrreq;
    output   empty;
    output   full;
    output [FORCE_BUFFER_WIDTH-1:0]  q;
    output [FORCE_BUFFER_ADDR_WIDTH-1:0]  usedw;

    wire  sub_wire0;
    wire  sub_wire1;
    wire [FORCE_BUFFER_WIDTH-1:0] sub_wire2;
    wire [FORCE_BUFFER_ADDR_WIDTH-1:0] sub_wire3;
    wire  empty = sub_wire0;
    wire  full = sub_wire1;
    wire [FORCE_BUFFER_WIDTH-1:0] q = sub_wire2[FORCE_BUFFER_WIDTH-1:0];
    wire [FORCE_BUFFER_ADDR_WIDTH-1:0] usedw = sub_wire3[FORCE_BUFFER_ADDR_WIDTH-1:0];

    scfifo  scfifo_component (
                .clock (clock),
                .data (data),
                .rdreq (rdreq),
                .wrreq (wrreq),
                .empty (sub_wire0),
                .full (sub_wire1),
                .q (sub_wire2),
                .usedw (sub_wire3),
                .aclr (),
                .almost_empty (),
                .almost_full (),
                .eccstatus (),
                .sclr ());
    defparam
        scfifo_component.add_ram_output_register  = "OFF",
        scfifo_component.enable_ecc  = "FALSE",
        scfifo_component.intended_device_family  = "Stratix 10",
        scfifo_component.lpm_numwords  = FORCE_BUFFER_DEPTH,
        scfifo_component.lpm_showahead  = "OFF",
        scfifo_component.lpm_type  = "scfifo",
        scfifo_component.lpm_width  = FORCE_BUFFER_WIDTH,
        scfifo_component.lpm_widthu  = FORCE_BUFFER_ADDR_WIDTH,
        scfifo_component.overflow_checking  = "ON",
        scfifo_component.underflow_checking  = "ON",
        scfifo_component.use_eab  = "ON";


endmodule