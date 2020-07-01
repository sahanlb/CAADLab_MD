module CTRL_RST (
		input  wire [0:0] data,    //  ram_input.datain
		input  wire [0:0] address, //           .address
		input  wire       wren,    //           .wren
		input  wire       clock,   //           .clk
		output wire [0:0] q        // ram_output.dataout
	);
endmodule

