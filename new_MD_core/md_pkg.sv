package md_pkg;

parameter SQRT_2                = 10'b0101101011;
parameter SQRT_3                = 10'b0110111100;
parameter EXP_0                 = 8'b01111111;
parameter NUM_CELLS             = 64;
parameter OFFSET_WIDTH          = 29;
parameter DATA_WIDTH            = 32;
parameter CELL_ID_WIDTH         = 3;
parameter PARTICLE_ID_WIDTH     = 7;
parameter NODE_ID_WIDTH         = $clog2(NUM_CELLS);
parameter NUM_NEIGHBOR_CELLS    = 13;
parameter NUM_FILTER            = 7;
parameter BODY_BITS             = 8;
parameter DECIMAL_ADDR_WIDTH    = 2;
parameter CELL_1                = 3'b001;
parameter CELL_2                = 3'b010;
parameter CELL_3                = 3'b011;
parameter SEGMENT_NUM				    = 9;
parameter SEGMENT_WIDTH			    = 4;
parameter BIN_NUM						    = 256;
parameter BIN_WIDTH					    = 8;
parameter X_DIM                 = 4;
parameter Y_DIM                 = 4;
parameter Z_DIM                 = 4;
parameter NUM_PARTICLE_PER_CELL = 100;

//particle ID
typedef logic [PARTICLE_ID_WIDTH-1:0] particle_id_t;

// Full cell ID {cell_id_z, cell_id_y, cell_id_x}
typedef struct packed{
  logic [CELL_ID_WIDTH-1    :0] cell_id_z;
  logic [CELL_ID_WIDTH-1    :0] cell_id_y;
  logic [CELL_ID_WIDTH-1    :0] cell_id_x;
} full_cell_id_t;


// Full ID {full cell ID, particle_id}
typedef struct packed{
  full_cell_id_t cell_id;
  particle_id_t  particle_id;
} full_id_t;


// Offset 3-tuple
typedef struct packed{
  logic [OFFSET_WIDTH-1:0] offset_z;
  logic [OFFSET_WIDTH-1:0] offset_y;
  logic [OFFSET_WIDTH-1:0] offset_x;
} offset_tuple_t;


// Data 3-tuple
typedef struct packed{
  logic [DATA_WIDTH-1:0] data_z;
  logic [DATA_WIDTH-1:0] data_y;
  logic [DATA_WIDTH-1:0] data_x;
} data_tuple_t;


// Force writeback {full id, data tuple}
typedef struct packed{
  full_id_t    id;
  data_tuple_t force_val;
}force_wb_t;


// Force data type {particle id, data tuple}
typedef struct packed{
  particle_id_t particle_id;
  data_tuple_t  force_val;
}force_data_t;


// Data tuple with particle ID
typedef struct packed{
  particle_id_t particle_id;
  data_tuple_t  position;
}position_data_t;


// Network packet {destination id, force_data_t}
typedef struct packed{
  logic [NODE_ID_WIDTH-1:0] dest_id;
  force_data_t              payload;
}packet_t;


// {cell_id, fixed_point_position} representation of position data
typedef struct packed{
  logic [CELL_ID_WIDTH-1:0] cell_id;
  logic [OFFSET_WIDTH-1:0] pos_offset;
}fixed_position_t;

// Input type for filters
typedef struct packed{
  logic [CELL_ID_WIDTH-1:0] cell_id;
  logic [BODY_BITS-1:0] body_bits;
}filter_input_t;





endpackage
