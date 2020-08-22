////////////////////////////////////////////////////////////////
// Select the buffer(s) to be written to
// Special control for the home cell force buffer's input
////////////////////////////////////////////////////////////////
module force_buffer_select
#(
	parameter NUM_FILTER = 7, 
	parameter CELL_ID_WIDTH = 3, 
	parameter FORCE_BUFFER_WIDTH = 5, 
	// Order: ZYX		 {322, 212, 223, 231, 132, 121, 111, 113, 133, 131, 112, 233, 321, 222}
	parameter CELL_1 = 3'b001, 
	parameter CELL_2 = 3'b010, 
	parameter CELL_3 = 3'b011, 
	parameter CELL_222 = {CELL_2, CELL_2, CELL_2}, 
	parameter CELL_111 = {CELL_1, CELL_1, CELL_1}, 
	parameter CELL_321 = {CELL_3, CELL_2, CELL_1}, 
	parameter CELL_121 = {CELL_1, CELL_2, CELL_1}, 
	parameter CELL_233 = {CELL_2, CELL_3, CELL_3}, 
	parameter CELL_132 = {CELL_1, CELL_3, CELL_2}, 
	parameter CELL_112 = {CELL_1, CELL_1, CELL_2}, 
	parameter CELL_231 = {CELL_2, CELL_3, CELL_1}, 
	parameter CELL_131 = {CELL_1, CELL_3, CELL_1}, 
	parameter CELL_223 = {CELL_2, CELL_2, CELL_3}, 
	parameter CELL_133 = {CELL_1, CELL_3, CELL_3}, 
	parameter CELL_212 = {CELL_2, CELL_1, CELL_2}, 
	parameter CELL_113 = {CELL_1, CELL_1, CELL_3}, 
	parameter CELL_322 = {CELL_3, CELL_2, CELL_2}
)
(
	input ref_force_valid, 
	input force_valid, 
	input [3*CELL_ID_WIDTH-1:0] cell_id, 
	input [FORCE_BUFFER_WIDTH-1:0] force_buffer_data_in, 
	input [FORCE_BUFFER_WIDTH-1:0] force_buffer_data_in_ref, 
	
	output reg [FORCE_BUFFER_WIDTH-1:0] force_buffer_data_homecell, 
	output reg [NUM_FILTER-1:0] force_buffer_wr_en, 
	output reg ref_selected, 
	output reg force_dst
);
always@(*)
	begin
	if (ref_force_valid && cell_id != CELL_222 && cell_id != CELL_111)
		begin
		force_buffer_data_homecell = force_buffer_data_in_ref;
		ref_selected = 1'b1;
		end
	else
		begin
		force_buffer_data_homecell = force_buffer_data_in;
		ref_selected = 1'b0;
		end
	end

always@(*)
	begin
	// If not valid, do not write
	if (force_valid)
		begin
		case(cell_id)
			CELL_222:
				begin
				force_buffer_wr_en = 7'b0000001;
				force_dst = 1'b0;
				end
			CELL_111:
				begin
				force_buffer_wr_en = 7'b0000001;
				force_dst = 1'b1;
				end
			CELL_321:
				begin
				force_buffer_wr_en = 7'b0000010;
				force_dst = 1'b0;
				end
			CELL_121:
				begin
				force_buffer_wr_en = 7'b0000010;
				force_dst = 1'b1;
				end
			CELL_233:
				begin
				force_buffer_wr_en = 7'b0000100;
				force_dst = 1'b0;
				end
			CELL_132:
				begin
				force_buffer_wr_en = 7'b0000100;
				force_dst = 1'b1;
				end
			CELL_112:
				begin
				force_buffer_wr_en = 7'b0001000;
				force_dst = 1'b0;
				end
			CELL_231:
				begin
				force_buffer_wr_en = 7'b0001000;
				force_dst = 1'b1;
				end
			CELL_131:
				begin
				force_buffer_wr_en = 7'b0010000;
				force_dst = 1'b0;
				end
			CELL_223:
				begin
				force_buffer_wr_en = 7'b0010000;
				force_dst = 1'b1;
				end
			CELL_133:
				begin
				force_buffer_wr_en = 7'b0100000;
				force_dst = 1'b0;
				end
			CELL_212:
				begin
				force_buffer_wr_en = 7'b0100000;
				force_dst = 1'b1;
				end
			CELL_113:
				begin
				force_buffer_wr_en = 7'b1000000;
				force_dst = 1'b0;
				end
			CELL_322:
				begin
				force_buffer_wr_en = 7'b1000000;
				force_dst = 1'b1;
				end
			default:
				begin
				force_buffer_wr_en = 0;
				force_dst = 1'b0;
				end
		endcase
		end
	else
		begin
		force_buffer_wr_en = 0;
		force_dst = 1'b0;
		end
	end

endmodule
