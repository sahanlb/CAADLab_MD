///////////////////////////////////////////////////////////////////////////////
// Module: destination_id_map
// Function: Wrapper module for the cell ID to destination ID mapping modules 
// (1 per node on the ring).
// Mapping modules accept writeback requests from each force pipeline, convert 
// neighbor cell ID to a network node ID, and output the packets ready to be 
// sent into the ring network
///////////////////////////////////////////////////////////////////////////////
import md_pkg::*;

module destination_id_map (
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
  for(k=0; k<Z_DIM; k++)begin: zloop
    for(j=0; j<Y_DIM; j++)begin: yloop
      for(i=0; i<X_DIM; i++)begin: xloop
        cell_to_dest_id_map #(
          .HOME_CELL_ID(k*X_DIM*Y_DIM + j*X_DIM + i),
          .HOME_X(i+1),
          .HOME_Y(j+1),
          .HOME_Z(k+1)
        ) map_inst (
          .wb_in(wb_in[k*X_DIM*Y_DIM + j*X_DIM + i]),

          .pkt_out(pkt_out[k*X_DIM*Y_DIM + j*X_DIM + i])
        );
      end
    end
  end
endgenerate

endmodule
