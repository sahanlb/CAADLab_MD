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
endmodule

