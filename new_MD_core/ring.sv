///////////////////////////////////////////////////////////////////////////////
// Module: ring
//
// The ring interconnect. Instantiates the 'ring nodes' and links connecting 
// the nodes.
///////////////////////////////////////////////////////////////////////////////

module ring #(
  parameter NUM_CELLS         = 64,
  parameter DATA_WIDTH        = 32,
  parameter PARTICLE_ID_WIDTH = 7,
  parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH,
	parameter FORCE_DATA_WIDTH  = FORCE_CACHE_WIDTH + PARTICLE_ID_WIDTH,
  parameter PACKET_WIDTH      = FORCE_DATA_WIDTH + $clog2(NUM_CELLS)
)(
  input  clk,
  input  rst,
  input  [NUM_CELLS-1:0][PACKET_WIDTH-1:0] packet_in, //{dest_id, payload}
  input  [NUM_CELLS-1:0] packet_valid,

  output [NUM_CELLS-1:0] ready,
  output [NUM_CELLS-1:0] data_valid,
  output [NUM_CELLS-1:0][FORCE_DATA_WIDTH-1:0] data_out
);
// Declare wires to connect the nodes
logic [NUM_CELLS-1:0][PACKET_WIDTH-1:0] nw_link_in, nw_link_out;
logic [NUM_CELLS-1:0] nw_valid_in, nw_valid_out;

assign nw_link_in[0]  = nw_link_out[NUM_CELLS];
assign nw_valid_in[0] = nw_valid_out[NUM_CELLS];
assign nw_link_in[NUM_CELLS-1:1]  = nw_link_out[NUM_CELLS-2:0];
assign nw_valid_in[NUM_CELLS-1:1] = nw_valid_out[NUM_CELLS-2:0];

genvar i;

// Instantiate the nodes
generate
  for(i=0; i<NUM_CELLS; i++)begin: ring_nodes
    ring_node #(
      .DATA_WIDTH(DATA_WIDTH),
      .PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
      .NODE_ID_WIDTH($clog2(NUM_CELLS)),
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
