// ForceEval_FIFO.v

// Generated using ACDS version 18.0 219

`timescale 1 ps / 1 ps
module ForceEval_FIFO (
		input  wire [112:0] data,  //  fifo_input.datain
		input  wire         wrreq, //            .wrreq
		input  wire         rdreq, //            .rdreq
		input  wire         clock, //            .clk
		output wire [112:0] q,     // fifo_output.dataout
		output wire [8:0]   usedw, //            .usedw
		output wire         full,  //            .full
		output wire         empty  //            .empty
	);

	ForceEval_FIFO_fifo_180_zggjfyi fifo_0 (
		.data  (data),  //   input,  width = 113,  fifo_input.datain
		.wrreq (wrreq), //   input,    width = 1,            .wrreq
		.rdreq (rdreq), //   input,    width = 1,            .rdreq
		.clock (clock), //   input,    width = 1,            .clk
		.q     (q),     //  output,  width = 113, fifo_output.dataout
		.usedw (usedw), //  output,    width = 9,            .usedw
		.full  (full),  //  output,    width = 1,            .full
		.empty (empty)  //  output,    width = 1,            .empty
	);

endmodule
