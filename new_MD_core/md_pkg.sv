package md_pkg;

parameter NUM_CELLS         = 64;
parameter OFFSET_WIDTH      = 29;
parameter DATA_WIDTH        = 32;
parameter CELL_ID_WIDTH     = 3;
parameter PARTICLE_ID_WIDTH = 7;
parameter NODE_ID_WIDTH     = $clog2(NUM_CELLS);


// Full cell ID {cell_id_z, cell_id_y, cell_id_x}
typedef struct packed{
  logic [CELL_ID_WIDTH-1    :0] cell_id_z;
  logic [CELL_ID_WIDTH-1    :0] cell_id_y;
  logic [CELL_ID_WIDTH-1    :0] cell_id_x;
} full_cell_id_t;


// Full ID {full cell ID, particle_id}
typedef struct packed{
  full_cell_id_t                cell_id;
  logic [PARTICLE_ID_WIDTH-1:0] particle_id;
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
  logic [PARTICLE_ID_WIDTH-1:0] particle_id;
  data_tuple_t                  force_val;
}force_data_t;


// Network packet {destination id, force_data_t}
typedef struct packed{
  logic [NODE_ID_WIDTH-1:0] dest_id;
  force_data_t              payload;
}packet_t;


endpackage
