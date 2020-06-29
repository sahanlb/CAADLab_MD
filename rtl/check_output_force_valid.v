//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Force valid check: If write success and buffer empty, meaning the next force output is the same as the current used force.
// If not success and buffer empty, the force output is valid if not used before, and not valid if used, thus keep the state. 
// If success and buffer not empty, the next force is valid. 
// If not success and buffer not empty, current force is unused, thus valid. 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module check_output_force_valid
#(
	parameter NUM_FILTER = 7
)
(
	input clk, 
	input rst, 
	input [NUM_FILTER-1:0] force_buffer_empty, 
	input [NUM_FILTER-1:0] write_success, 
	
	output reg [NUM_FILTER-1:0] prev_force_buffer_empty, 
	output reg [NUM_FILTER-1:0] output_force_valid
);

// Check valid for all 7 force output buffers
genvar i;
generate
	for (i = 0; i < NUM_FILTER; i = i + 1)
		begin: check_force_valid
		always@(posedge clk)
			begin
			if (rst)
				begin
				prev_force_buffer_empty[i] <= 1'b1;
				output_force_valid[i] <= 1'b0;
				end
			else
				begin
				prev_force_buffer_empty[i] <= force_buffer_empty[i];
				if (force_buffer_empty[i])
					begin
					if (write_success[i])
						begin
						output_force_valid[i] <= 1'b0;
						end
					else
						begin
						output_force_valid[i] <= output_force_valid[i];
						end
					end
				// If not empty, valid
				else
					begin
					output_force_valid[i] <= 1'b1;
					end
				end
			end
		end
endgenerate

endmodule