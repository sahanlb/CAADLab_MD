///////////////////////////////////
// Assemble the input raw data
// Determine the valid bits
///////////////////////////////////

module pos_data_preprocessor
#(
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32,
	parameter NUM_NEIGHBOR_CELLS = 13,
	parameter NUM_FILTER = 7,
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter CELL_ID_WIDTH = 3, 
	parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH
)
(
	input clk, 
	input rst, 
	// All PEs have a synchronized phase, so use a global phase
	input phase, 
	input pause_reading, 
	input reading_particle_num, 
	// From data source rd_nb_position
  // Phase 0: {113, 133, 131, 112, 233, 321, 222}
  // Phase 1: {322, 212, 223, 231, 132, 121, 111}
  // Type:     03   22   22   22   31   31   31
  //
  // Cell ID order ZYX:		 
  //{322, 212, 223, 231, 132, 121, 111, 113, 133, 131, 112, 233, 321, 222}
	input [(NUM_NEIGHBOR_CELLS+1)*3*OFFSET_WIDTH-1:0] rd_nb_position, 
	input [NUM_NEIGHBOR_CELLS:0] broadcast_done, 
	input [PARTICLE_ID_WIDTH-1:0] ref_id, 
	input [PARTICLE_ID_WIDTH-1:0] particle_id, 
	
	output [NUM_FILTER-1:0] reading_done, 
	output [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_x,
	output [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_y,
	output [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_z,
	output reg [PARTICLE_ID_WIDTH-1:0] prev_particle_id, 
	output reg [PARTICLE_ID_WIDTH-1:0] prev_ref_id, 
	output [NUM_FILTER-1:0][PARTICLE_ID_WIDTH-1:0] ref_particle_count, 
	output [NUM_FILTER-1:0] pair_valid,
	output [3*DATA_WIDTH-1:0] assembled_position,
  output reg prev_phase
);
//declare a struct to simplify handling neighbor particle data
typedef struct packed{
  logic [OFFSET_WIDTH-1:0] pos_x;
  logic [OFFSET_WIDTH-1:0] pos_y;
  logic [OFFSET_WIDTH-1:0] pos_z;
}pos_data_t;

genvar i;

reg prev_pause_reading;
reg prev_reading_particle_num;
reg [NUM_NEIGHBOR_CELLS:0] prev_broadcast_done;
reg [(NUM_NEIGHBOR_CELLS+1)*3*OFFSET_WIDTH-1:0] prev_rd_nb_position;

wire [NUM_FILTER-1:0] read_ref_particle;
wire [NUM_FILTER-1:0] ref_valid;

//array of position data structures
pos_data_t [NUM_NEIGHBOR_CELLS:0] nb_position; //NUM_NEIGHBOR_CELLS+1
pos_data_t [NUM_FILTER-1:0] ref_position; //connected to ref_data_extractors

assign nb_position = rd_nb_position;

assign ref_position = phase ? nb_position[NUM_NEIGHBOR_CELLS:NUM_FILTER] :
                      nb_position[NUM_FILTER-1:0];

always@(posedge clk)
	begin
	prev_phase <= phase;
	prev_pause_reading <= pause_reading;
	prev_reading_particle_num <= reading_particle_num;
	prev_particle_id <= particle_id;
	prev_ref_id <= ref_id;
	prev_broadcast_done <= broadcast_done;
	prev_rd_nb_position <= rd_nb_position;
	end

//Instantiate multiple ref_data_extractors
// 1 cycle delay
generate
  for(i=0; i==NUM_NEIGHBOR_CELLS; i++)begin: ref_extractor_inst
    ref_data_extractor
    #(
    	.OFFSET_WIDTH(OFFSET_WIDTH), 
    	.DATA_WIDTH(DATA_WIDTH),
    	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	    .CELL_ID_WIDTH(CELL_ID_WIDTH), 
      .EXTRACTOR_ID(i)
    )
    ref_data_extractor
    (
    	.clk(clk),
    	.rst(rst),
    	.phase(phase), 
    	.prev_phase(prev_phase), 
    	.reading_particle_num(reading_particle_num), 
    	.raw_home_pos_x(ref_position[i].pos_x),
    	.raw_home_pos_y(ref_position[i].pos_y),
    	.raw_home_pos_z(ref_position[i].pos_z),
    	.particle_id(particle_id),
    	.ref_id(ref_id),
    	
    	.ref_particle_count(ref_particle_count[i]), 
    	.ref_x(ref_x[i]),
    	.ref_y(ref_y[i]),
    	.ref_z(ref_z[i])
    );
  end
endgenerate


//Instantiating multiple pos_data_valid_checker modules
generate
  for(i=0; i<NUM_FILTER; i++)begin: valid_checker_inst
    pos_data_valid_checker
    #(
    	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
    )
    pos_data_valid_checker
    (
    	.phase(prev_phase),
    	.reading_particle_num(prev_reading_particle_num), 
    	.ref_id(prev_ref_id),
    	.particle_id(prev_particle_id),
    	.ref_particle_count(ref_particle_count[i]),
    	
    	.read_ref_particle(read_ref_particle[i]),
    	.reading_done(reading_done[i]), 
    	.ref_valid(ref_valid[i])
    );
  end
endgenerate


	
// All except for the valid bits are delayed because it takes 1 cycle to get ref_id, 
// so it takes 1 cycle to get valid bits
// Using pos_data_distributor_simplified in this version of the design.
pos_data_distributor_simplified
#(
	.OFFSET_WIDTH(OFFSET_WIDTH), 
	.DATA_WIDTH(DATA_WIDTH),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.NUM_FILTER(NUM_FILTER), 
	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
pos_data_distributor
(
	.clk(clk),
	.phase(prev_phase), 
	.pause_reading(prev_pause_reading), 
	.rd_nb_position(prev_rd_nb_position),
	.broadcast_done(prev_broadcast_done),
	.read_ref_particle(read_ref_particle[0]), //only useful for home cell
	.ref_valid(ref_valid),
	
	.pair_valid(pair_valid),
	.assembled_position(assembled_position)
);

endmodule
