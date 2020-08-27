///////////////////////////////////////////////////////////
// Capture reference particle data from the broadcasted
// particle data, and records the reference particle id
///////////////////////////////////////////////////////////
import md_pkg::*;

module ref_data_extractor
#(
  parameter EXTRACTOR_ID      = 0 //use to add correct cell IDs
)
(
	input clk, 
	input rst, 
	input phase, 
	input prev_phase, 
	input reading_particle_num, 
	// Particle data from home cell
  input offset_tuple_t raw_home_pos,
	input particle_id_t particle_id, 
	input particle_id_t ref_id, 
	
	output particle_id_t ref_particle_count, 
  output data_tuple_t ref_pos
);

data_tuple_t next_ref, home_pos;

full_cell_id_t cell_id;

// For half shell selection
always @(*)begin
  case(EXTRACTOR_ID)
    0:cell_id = phase ? {CELL_3, CELL_1, CELL_3} : {CELL_2, CELL_2, CELL_2};
    1:cell_id = phase ? {CELL_3, CELL_2, CELL_1} : {CELL_2, CELL_2, CELL_3};
    2:cell_id = phase ? {CELL_3, CELL_2, CELL_2} : {CELL_2, CELL_3, CELL_1};
    3:cell_id = phase ? {CELL_3, CELL_2, CELL_3} : {CELL_2, CELL_3, CELL_2};
    4:cell_id = phase ? {CELL_3, CELL_3, CELL_1} : {CELL_2, CELL_3, CELL_3};
    5:cell_id = phase ? {CELL_3, CELL_3, CELL_2} : {CELL_3, CELL_1, CELL_1};
    6:cell_id = phase ? {CELL_3, CELL_3, CELL_3} : {CELL_3, CELL_1, CELL_2};
  endcase
end

// Assemble cell id and offset
assign home_pos.data_x = {cell_id.cell_id_x, raw_home_pos.offset_x};
assign home_pos.data_y = {cell_id.cell_id_y, raw_home_pos.offset_y};
assign home_pos.data_z = {cell_id.cell_id_z, raw_home_pos.offset_z};

always@(posedge clk)
	begin
	if (rst)
		begin
		ref_pos            <= 0;
		next_ref           <= 0;
		ref_particle_count <= 0;
		end
	else 
		begin
		if (reading_particle_num)
			begin
			// Pick the lowest 7 bits as the number of particles
			ref_particle_count <= raw_home_pos.offset_x[PARTICLE_ID_WIDTH-1:0];
			end
		else
			begin
			// Phase 1 to phase 0 transition, meaning a ref particle has just been processed
			if (prev_phase == 1'b1 && phase == 1'b0)
				begin
        ref_pos <= next_ref;
				end
			else
				begin
				if (ref_id + 1'b1 == particle_id)
					begin
					next_ref <= home_pos;
					end
				// Mainly used for the 1st ref data, because there's no next_ref data at the beginning
				else if (ref_id == particle_id)
					begin
					ref_pos <= home_pos;
					end
				end
			end
		end
	end

endmodule
