module cell_to_dest_id_map #(
  parameter NUM_CELLS         = 64,
	parameter DATA_WIDTH        = 32, 
	parameter CELL_ID_WIDTH     = 3, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter ID_WIDTH          = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
  parameter WB_WIDTH          = ID_WIDTH + 3*DATA_WIDTH,
  parameter NODE_ID_WIDTH     = 6, // log2(NUMBER OF CELLS)
  parameter PACKET_WIDTH      = 3*DATA_WIDTH + PARTICLE_ID_WIDTH + NODE_ID_WIDTH,
  parameter HOME_CELL_ID      = 0,
  parameter HOME_X            = 1,
  parameter HOME_Y            = 1,
  parameter HOME_Z            = 1,
  parameter NX                = 4,
  parameter NY                = 4,
  parameter NZ                = 4,
  parameter NXY               = NX*NY,
  parameter NXYZ              = NX*NY*NZ
)(
  input  [WB_WIDTH-1:0] wb_in,
  output [PACKET_WIDTH-1:0] pkt_out
);

localparam CELL_1 = 3'b001;
localparam CELL_2 = 3'b010;
localparam CELL_3 = 3'b011;

wire [CELL_ID_WIDTH-1:0] cellx, celly, cellz;

assign cellx = wb_in[WB_WIDTH-1-2*CELL_ID_WIDTH -: CELL_ID_WIDTH];
assign celly = wb_in[WB_WIDTH-1-1*CELL_ID_WIDTH -: CELL_ID_WIDTH];
assign cellz = wb_in[WB_WIDTH-1-0*CELL_ID_WIDTH -: CELL_ID_WIDTH];

unsigned int hops, destination;

wire [NODE_ID_WIDTH-1:0] dest_id;

/*
Case statement in not fully specified. Only the cells is the half shell are specified.
If one wants to use a different neighbor selection scheme, more cases need to be added.
*/

always_comb begin
  case({cellz, celly, cellx}) //{Z,Y,X}
    {CELL_2, CELL_2, CELL_3}:begin
      if(HOME_X == NX) //periodic boundary on +X direction
        hops = NXYZ - NX + 1;
      else
        hops = 1;
    end
    {CELL_2, CELL_3, CELL_1}:begin
      if(HOME_X == 1 & HOME_Y == NY)
        hops = NXYZ - NXY + 2*NX - 1;
      else if(HOME_X == 1)
        hops = 2*NX - 1;
      else if(HOME_Y == NY)
        hops = NXYZ - NXY + NX - 1;
      else
        hops = NX - 1;
    end
    {CELL_2, CELL_3, CELL_2}:begin
      if(HOME_Y == NY)
        hops = NXYZ - NXY + NX;
      else
        hops = NX;
    end
    {CELL_2, CELL_3, CELL_3}:begin
      if(HOME_X == NX & HOME_Y == NY)
        hops = NXYZ - NXY + 1;
      else if(HOME_Y == NY)
        hops = NXYZ - NXY + NX + 1;
      else if(HOME_X == NX)
        hops = 1;
      else
        hops = NX + 1;
    end
    {CELL_3, CELL_1, CELL_1}:begin
      if(HOME_X == 1 & HOME_Y == 1)
        hops = 2*NXY - 1;
      else if(HOME_Y == 1)
        hops = 2*NXY - NX - 1;
      else if(HOME_X == 1)
        hops = NXY - 1;
      else
        hops = NXY - NX - 1;
    end
    {CELL_3, CELL_1, CELL_2}:begin
      if(HOME_Y == 1)
        hops = 2*NXY - NX;
      else
        hops = NXY - NX;
    end
    {CELL_3, CELL_1, CELL_3}:begin
      if(HOME_X == NX & HOME_Y == 1)
        hops = 2*NXY - 2*NX + 1;
      else if(HOME_Y == 1)
        hops = 2*NXY - NX + 1;
      else if(HOME_X == NX)
        hops = NXY - 2*NX + 1;
      else
        hops = NXY - NX + 1;
    end
    {CELL_3, CELL_2, CELL_1}:begin
      if(HOME_X == 1)
        hops = NXY + NX - 1;
      else
        hops = NXY - 1;
    end
    {CELL_3, CELL_2, CELL_2}:begin
      hops = NXY;
    end
    {CELL_3, CELL_2, CELL_3}:begin
      if(HOME_X == NX)
        hops = NXY - NX + 1;
      else
        hops = NXY + 1;
    end
    {CELL_3, CELL_3, CELL_1}:begin
      if(HOME_X == 1 & HOME_Y == NY)
        hops = 2*NX - 1;
      else if(HOME_Y == NY)
        hops = NX - 1;
      else if(HOME_X == 1)
        hops = NXY + 2*NX - 1;
      else
        hops = NXY + NX - 1;
    end
    {CELL_3, CELL_3, CELL_2}:begin
      if(HOME_Y == NY)
        hops = NX;
      else
        hops = NXY + NX;
    end
    {CELL_3, CELL_3, CELL_3}:begin
      if(HOME_X == NX & HOME_Y == NY)
        hops = 1;
      else if(HOME_Y == NY)
        hops = NX + 1;
      else if(HOME_X == NX)
        hops = NXY + 1;
      else
        hops = NXY + NX + 1;
    end
    default:begin
      hops = 0;
      $display("Unexpected neighbor cell ID sent to cell to destination mapper.");
      $stop();
    end
  endcase
end


assign dest_id = (HOME_CELL_ID + hops >= NUM_CELLS) ? (HOME_CELL_ID + hops - NUM_CELLS) :
                 (HOME_CELL_ID + hops);


assign pkt_out[0 +: (3*DATA_WIDTH+PARTICLE_ID_WIDTH)] = wb_in[0 +: (3*DATA_WIDTH+PARTICLE_ID_WIDTH)];
assign pkt_out[PACKET_WIDTH-1 -: NODE_ID_WIDTH] = dest_id;

endmodule
