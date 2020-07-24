///////////////////////////////////////////////////////////////////////////////
// Module: ring_node
//
// Single node in the ring interconnect.Inputs from short range force 
// calculation units and previous node on the ring. Outputs to either the 
// force cache connectd directly or the next node on the ring.
///////////////////////////////////////////////////////////////////////////////
import md_pkg::*;

module ring_node #(
  parameter DATA_WIDTH        = 32,
  parameter PARTICLE_ID_WIDTH = 7,
  parameter NODE_ID_WIDTH     = 6, //log2(NUM_CELLS)
  parameter HOME_CELL_ID      = 0,
  parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH,
	parameter FORCE_DATA_WIDTH  = FORCE_CACHE_WIDTH + PARTICLE_ID_WIDTH,
  parameter PACKET_WIDTH      = FORCE_DATA_WIDTH + NODE_ID_WIDTH
)(
  input  clk,
  input  rst,
  // From local PE
  input  packet_t pe_pkt_in,
  input  pe_pkt_valid,
  // From previous node on the ring
  input  packet_t prev_pkt_in,
  input  prev_pkt_valid,

  // To force cache
  output force_data_t fc_data_out,
  output reg fc_data_valid,
  // To next node
  output packet_t nxt_pkt_out,
  output reg nxt_pkt_valid,
  // To local PE
  output reg pe_ready
);

// Buffers
packet_t pe_buf;
logic pe_buf_valid;

// destination address comparisons
logic pe_dest_match, nw_dest_match, pe_buf_dest_match;

assign pe_dest_match     = (pe_pkt_in.dest_id == HOME_CELL_ID);
assign nw_dest_match     = (prev_pkt_in.dest_id == HOME_CELL_ID);
assign pe_buf_dest_match = (pe_buf.dest_id == HOME_CELL_ID);

/*
* NW packets don't need to be buffered because anything coming from previous node goes through.
* Input from PE gets to go through only when there's no collision with the NW packet or
  when there is no packet coming over the network.
* No ready signals among network nodes. Each node gives priority to network packets over 
  packets injected by the local PE. Therefore, each node can simply forward packets to the 
  next node without a ready signal.
*/


// Separate logic to handle each of the outputs
// PE packet buffer and ready signal to the PE
always_ff @(posedge clk)begin
  if(rst)begin
    pe_buf       <= 0;
    pe_buf_valid <= 1'b0;
    pe_ready     <= 1'b1;
  end
  else begin
    if(pe_ready & pe_pkt_valid & prev_pkt_valid & ((pe_dest_match & nw_dest_match) | (~pe_dest_match & ~nw_dest_match)))begin
      pe_buf       <= pe_pkt_in;
      pe_buf_valid <= 1'b1;
      pe_ready     <= 1'b0;
    end
    else if(pe_buf_valid & (~prev_pkt_valid | (pe_buf_dest_match & ~nw_dest_match) | (~pe_buf_dest_match & nw_dest_match)))begin
      pe_buf_valid <= 1'b0;
      pe_ready     <= 1'b1;
    end
  end
end

// Output to force cache
always_ff @(posedge clk)begin
  if(rst)begin
    fc_data_out   <= 0;
    fc_data_valid <= 1'b0;
  end
  else begin
    if(prev_pkt_valid & nw_dest_match)begin
      fc_data_out   <= prev_pkt_in.payload;
      fc_data_valid <= 1'b1;
    end
    else if(pe_buf_valid & pe_buf_dest_match)begin
      fc_data_out   <= pe_buf.payload;
      fc_data_valid <= 1'b1;
    end
    else if(pe_pkt_valid & pe_dest_match)begin
      fc_data_out   <= pe_pkt_in.payload;
      fc_data_valid <= 1'b1;
    end
    else begin
      fc_data_out   <= 0;
      fc_data_valid <= 1'b0;
    end
  end
end

// Output to next node
always_ff @(posedge clk)begin
  if(rst)begin
    nxt_pkt_out   <= 0;
    nxt_pkt_valid <= 1'b0;
  end
  else begin
    if(prev_pkt_valid & ~nw_dest_match)begin
      nxt_pkt_out   <= prev_pkt_in;
      nxt_pkt_valid <= 1'b1;
    end
    else if(pe_buf_valid & ~pe_buf_dest_match)begin
      nxt_pkt_out   <= pe_buf;
      nxt_pkt_valid <= 1'b1;
    end
    else if(pe_pkt_valid & ~pe_dest_match)begin
      nxt_pkt_out   <= pe_pkt_in;
      nxt_pkt_valid <= 1'b1;
    end
    else begin
      nxt_pkt_out   <= 0;
      nxt_pkt_valid <= 1'b0;
    end
  end
end

endmodule
