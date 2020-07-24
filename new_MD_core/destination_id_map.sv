///////////////////////////////////////////////////////////////////////////////
// Module: destination_id_map
// Function: Wrapper module for the cell ID to destination ID mapping modules 
// (1 per node on the ring).
// Mapping modules accept writeback requests from each force pipeline, convert 
// neighbor cell ID to a network node ID, and output the packets ready to be 
// sent into the ring network
///////////////////////////////////////////////////////////////////////////////
import md_pkg::*;

module destination_id_map #(
  parameter NUM_CELLS         = 64,
  parameter DATA_WIDTH        = 32,
	parameter CELL_ID_WIDTH     = 3, 
  parameter PARTICLE_ID_WIDTH = 7,
  parameter XSIZE             = 4,
  parameter YSIZE             = 4,
  parameter ZSIZE             = 4,
  parameter NODE_ID_WIDTH     = $clog2(NUM_CELLS)
)(
  input force_wb_t [NUM_CELLS-1:0] wb_in,
  
  output packet_t [NUM_CELLS-1:0] pkt_out 
);

genvar i,j,k;

/*
Instantiating cell to destination ID map modules.
loops are used to assign the correct values to home cell location parameters.
Cell indexing starts from 1 instead of 0 because that is the indexing convention used throughout the design.
*/
generate
  for(k=0; k<ZSIZE; k++)begin: zloop
    for(j=0; j<YSIZE; j++)begin: yloop
      for(i=0; i<XSIZE; i++)begin: xloop
        cell_to_dest_id_map #(
          .NUM_CELLS(NUM_CELLS),
        	.DATA_WIDTH(DATA_WIDTH), 
        	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
        	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH), 
          .NODE_ID_WIDTH(NODE_ID_WIDTH),
          .HOME_CELL_ID(k*XSIZE*YSIZE + j*XSIZE + i),
          .HOME_X(i+1),
          .HOME_Y(j+1),
          .HOME_Z(k+1),
          .NX(XSIZE),
          .NY(YSIZE),
          .NZ(ZSIZE)
        ) map_inst (
          .wb_in(wb_in[k*XSIZE*YSIZE + j*XSIZE + i]),

          .pkt_out(pkt_out[k*XSIZE*YSIZE + j*XSIZE + i])
        );
      end
    end
  end
endgenerate

endmodule
