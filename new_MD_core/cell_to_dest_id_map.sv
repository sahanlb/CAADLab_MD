import md_pkg::*;

module cell_to_dest_id_map #(
  parameter HOME_CELL_ID = 0,
  parameter HOME_X       = 1,
  parameter HOME_Y       = 1,
  parameter HOME_Z       = 1
)(
  input  force_wb_t wb_in,
  output packet_t pkt_out
);

localparam NX   = X_DIM;
localparam NY   = Y_DIM;
localparam NZ   = Z_DIM;
localparam NXY  = NX*NY;
localparam NXYZ = NX*NY*NZ;

wire [CELL_ID_WIDTH-1:0] cellx, celly, cellz;

assign cellx = wb_in.id.cell_id.cell_id_x;
assign celly = wb_in.id.cell_id.cell_id_y;
assign cellz = wb_in.id.cell_id.cell_id_z;

int unsigned hops, destination;

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
      //$display("Unexpected neighbor cell ID sent to cell to destination mapper. %0d, %0d, %0d", cellz, celly, cellx);
      //$stop();
    end
  endcase
end


assign dest_id = (HOME_CELL_ID + hops >= NUM_CELLS) ? (HOME_CELL_ID + hops - NUM_CELLS) :
                 (HOME_CELL_ID + hops);

assign pkt_out.dest_id = dest_id;

assign pkt_out.payload.particle_id = wb_in.id.particle_id;

assign pkt_out.payload.force_val = wb_in.force_val;

endmodule
