///////////////////////////////////
// Assemble the input raw data
// Determine the valid bits
///////////////////////////////////
import md_pkg::*;

module pos_data_preprocessor(
	input clk, 
	input rst, 
	// All PEs have a synchronized phase, so use a global phase
	input phase, 
	input pause_reading, 
	input reading_particle_num, 
	// Mapping from data source rd_nb_position //
  // Half shell selection (Used in current version)
  // {ZYX}
  // Phase 0 : {312, 311, 233, 232, 231, 223, 222}
  // Phase 1 : {333, 332, 331, 323, 322, 321, 313}
  // rd_nb_position arrangement
  // {333, 332, 331, 323, 322, 321, 313, 312, 311, 233, 232, 231, 223, 222}
	input offset_tuple_t [NUM_NEIGHBOR_CELLS:0] rd_nb_position, 
	input particle_id_t ref_id, 
	input particle_id_t particle_id, 
	
	output reading_done, 
  output data_tuple_t [NUM_FILTER-1:0] ref_pos,
	output particle_id_t prev_ref_id, 
  output particle_id_t ref_particle_count,
	output particle_id_t prev_particle_id, 
	output [NUM_FILTER-1:0] pair_valid,
	output data_tuple_t assembled_position,
  output reg prev_phase
);
genvar i;

reg prev_pause_reading;
reg prev_reading_particle_num;
reg [NUM_NEIGHBOR_CELLS:0] prev_broadcast_done;
offset_tuple_t prev_rd_nb_position;

particle_id_t home_particle_count;

wire [NUM_FILTER-1:0] ref_particle_read;
wire [NUM_FILTER-1:0] ref_valid;

wire broadcast_done;

// Internal wires connected to ref_particle_count ports of ref_data_extractors
particle_id_t [NUM_FILTER-1:0] i_ref_particle_count; 

// Capture particle count for the home cell.
always_ff @(posedge clk)begin
  if(rst)
    home_particle_count <= 0;
  else if(prev_reading_particle_num & prev_phase == 0)
    home_particle_count <= i_ref_particle_count[0];
    // In phase 0, filter 0 gets the home cell.
  else
    home_particle_count <= home_particle_count;
end

// Set reading_done and broadcast_done
assign broadcast_done = (particle_id > home_particle_count) & (home_particle_count != 0);
assign reading_done   = (ref_id > home_particle_count) & (home_particle_count != 0);

assign ref_particle_count = home_particle_count;


//array of position data structures
offset_tuple_t [NUM_FILTER-1:0] ref_position; //connected to ref_data_extractors

assign ref_position = phase ? rd_nb_position[NUM_NEIGHBOR_CELLS:NUM_FILTER] :
                      rd_nb_position[NUM_FILTER-1:0];

always@(posedge clk)
	begin
	prev_phase <= phase;
	prev_pause_reading <= pause_reading;
	prev_reading_particle_num <= reading_particle_num;
	prev_particle_id <= particle_id;
	prev_ref_id <= ref_id;
	prev_broadcast_done <= broadcast_done;
	prev_rd_nb_position <= rd_nb_position[0];
	end

//Instantiate multiple ref_data_extractors
// 1 cycle delay
generate
  for(i=0; i<NUM_FILTER; i++)begin: ref_extractor_inst
    ref_data_extractor
    #(
      .EXTRACTOR_ID(i)
    )
    ref_data_extractor
    (
    	.clk(clk),
    	.rst(rst),
    	.phase(phase), 
    	.prev_phase(prev_phase), 
    	.reading_particle_num(reading_particle_num), 
    	.raw_home_pos(ref_position[i]),
    	.particle_id(particle_id),
    	.ref_id(ref_id),
    	
    	.ref_particle_count(i_ref_particle_count[i]), 
      .ref_pos(ref_pos[i])
    );
  end
endgenerate


//Instantiating multiple pos_data_valid_checker modules
generate
  for(i=0; i<NUM_FILTER; i++)begin: valid_checker_inst
    pos_data_valid_checker 
    pos_data_valid_checker(
    	.phase(prev_phase),
    	.reading_particle_num(prev_reading_particle_num), 
    	.ref_id(prev_ref_id),
    	.particle_id(prev_particle_id),
    	.ref_particle_count(i_ref_particle_count[i]),
    	
    	.ref_particle_read(ref_particle_read[i]),
    	.reading_done(), 
    	.ref_valid(ref_valid[i])
    );
  end
endgenerate


	
// All except for the valid bits are delayed because it takes 1 cycle to get ref_id, 
// so it takes 1 cycle to get valid bits
// Using pos_data_distributor_simplified in this version of the design.
pos_data_distributor_simplified
pos_data_distributor(
	.clk(clk),
	.phase(prev_phase), 
	.pause_reading(prev_pause_reading), 
	.rd_nb_position(prev_rd_nb_position),
	.broadcast_done(prev_broadcast_done),
	.ref_particle_read(ref_particle_read[0]), //only useful for home cell
	.ref_valid(ref_valid),
	
	.pair_valid(pair_valid),
	.assembled_position(assembled_position)
);

endmodule
