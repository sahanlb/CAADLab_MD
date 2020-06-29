///////////////////////////////////////////////////////////
// Capture reference particle data from the broadcasted
// particle data, and records the reference particle id
///////////////////////////////////////////////////////////

module ref_data_extractor
#(
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter CELL_2 = 3'b010
)
(
	input clk, 
	input rst, 
	input phase, 
	input prev_phase, 
	input reading_particle_num, 
	// Particle data from home cell
	input [OFFSET_WIDTH-1:0] raw_home_pos_x, 
	input [OFFSET_WIDTH-1:0] raw_home_pos_y, 
	input [OFFSET_WIDTH-1:0] raw_home_pos_z, 
	input [PARTICLE_ID_WIDTH-1:0] particle_id, 
	input [PARTICLE_ID_WIDTH-1:0] ref_id, 
	
	output reg [PARTICLE_ID_WIDTH-1:0] ref_particle_num, 
	output reg [DATA_WIDTH-1:0] ref_x, 
	output reg [DATA_WIDTH-1:0] ref_y, 
	output reg [DATA_WIDTH-1:0] ref_z
);

reg [DATA_WIDTH-1:0] next_ref_x;
reg [DATA_WIDTH-1:0] next_ref_y;
reg [DATA_WIDTH-1:0] next_ref_z;
wire [DATA_WIDTH-1:0] home_pos_x;
wire [DATA_WIDTH-1:0] home_pos_y;
wire [DATA_WIDTH-1:0] home_pos_z;

// Assemble cell id and offset
assign home_pos_x = {CELL_2, raw_home_pos_x};
assign home_pos_y = {CELL_2, raw_home_pos_y};
assign home_pos_z = {CELL_2, raw_home_pos_z};

always@(posedge clk)
	begin
	if (rst)
		begin
		ref_x <= 0;
		ref_y <= 0;
		ref_z <= 0;
		next_ref_x <= 0;
		next_ref_y <= 0;
		next_ref_z <= 0;
		ref_particle_num <= 0;
		end
	else 
		begin
		if (reading_particle_num)
			begin
			// Pick the lowest 7 bits as the number of particles
			ref_particle_num <= raw_home_pos_x[PARTICLE_ID_WIDTH-1:0];
			end
		else
			begin
			// Phase 1 to phase 0 transition, meaning a ref particle has just been processed
			if (prev_phase == 1'b1 && phase == 1'b0)
				begin
				ref_x <= next_ref_x;
				ref_y <= next_ref_y;
				ref_z <= next_ref_z;
				end
			else
				begin
				if (ref_id + 1'b1 == particle_id)
					begin
					next_ref_x <= home_pos_x;
					next_ref_y <= home_pos_y;
					next_ref_z <= home_pos_z;
					end
				// Mainly used for the 1st ref data, because there's no next_ref data at the beginning
				else if (ref_id == particle_id)
					begin
					ref_x <= home_pos_x;
					ref_y <= home_pos_y;
					ref_z <= home_pos_z;
					end
				end
			end
		end
	end

endmodule