module get_queuing_status
#(
	parameter NUM_FILTER = 7
)
(
	input [NUM_FILTER-1:0] output_force_valid, 
	input [NUM_FILTER-1:0] force_buffer_empty, 
	input [NUM_FILTER-1:0] prev_force_buffer_empty, 
	input [NUM_FILTER-1:0] write_success, 
	
	output reg [NUM_FILTER-1:0] queuing
);

genvar i;
generate
	for (i = 0; i < NUM_FILTER; i = i + 1)
		begin: queuing_status
		always@(*)
			begin
			if (~force_buffer_empty[i] && write_success[i])
				begin
				queuing[i] = 1'b0;
				end
			else if (~force_buffer_empty[i] && ~write_success[i])
				begin
				if (~prev_force_buffer_empty[i])
					begin
					queuing[i] = 1'b1;
					end
				else
					begin
					if (output_force_valid[i])
						begin
						queuing[i] = 1'b1;
						end
					else
						begin
						queuing[i] = 1'b0;
						end
					end
				end
			else if (force_buffer_empty[i] && ~write_success[i])
				begin
				if (~prev_force_buffer_empty[i])
					begin
					queuing[i] = 1'b1;
					end
				else
					begin
					if (output_force_valid[i])
						begin
						queuing[i] = 1'b1;
						end
					else
						begin
						queuing[i] = 1'b0;
						end
					end
				end
			else
				begin
				queuing[i] = 1'b0;
				end
			end
		end
endgenerate

endmodule