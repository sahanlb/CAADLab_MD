///////////////////////////////////////////////////////////////////////////////
// Module: ring
//
// The ring interconnect. Instantiates the 'ring nodes' and links connecting 
// the nodes.
///////////////////////////////////////////////////////////////////////////////
import md_pkg::*;

module ring (
  input  clk,
  input  rst,
  input  packet_t [NUM_CELLS-1:0] packet_in, //{dest_id, payload}
  input  [NUM_CELLS-1:0] packet_valid,

  output [NUM_CELLS-1:0] ready,
  output [NUM_CELLS-1:0] data_valid,
  output force_data_t [NUM_CELLS-1:0] data_out
);
// Declare wires to connect the nodes
packet_t [NUM_CELLS-1:0] nw_link_in, nw_link_out;
logic [NUM_CELLS-1:0] nw_valid_in, nw_valid_out;

assign nw_link_in[0]  = nw_link_out[NUM_CELLS-1];
assign nw_valid_in[0] = nw_valid_out[NUM_CELLS-1];
assign nw_link_in[NUM_CELLS-1:1]  = nw_link_out[NUM_CELLS-2:0];
assign nw_valid_in[NUM_CELLS-1:1] = nw_valid_out[NUM_CELLS-2:0];

genvar i;

// Instantiate the nodes
generate
  for(i=0; i<NUM_CELLS; i++)begin: ring_nodes
    ring_node #(
      .HOME_CELL_ID(i)
    ) node (
      .clk(clk),
      .rst(rst),
      .pe_pkt_in(packet_in[i]),
      .pe_pkt_valid(packet_valid[i]),
      .prev_pkt_in(nw_link_in[i]),
      .prev_pkt_valid(nw_valid_in[i]),
    
      .fc_data_out(data_out[i]),
      .fc_data_valid(data_valid[i]),
      .nxt_pkt_out(nw_link_out[i]),
      .nxt_pkt_valid(nw_valid_out[i]),
      .pe_ready(ready[i])
    );
  end
endgenerate

endmodule
