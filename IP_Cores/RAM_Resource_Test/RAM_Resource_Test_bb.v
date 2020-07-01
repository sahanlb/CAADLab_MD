module RAM_Resource_Test (
		input  wire [95:0] data,    //  ram_input.datain
		input  wire [14:0] address, //           .address
		input  wire        wren,    //           .wren
		input  wire        clock,   //           .clk
		output wire [95:0] q        // ram_output.dataout
	);
endmodule

