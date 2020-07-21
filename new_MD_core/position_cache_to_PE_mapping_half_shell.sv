///////////////////////////////////////////////////////////////////////////////
// Module: position_cache_to_PE_mapping_half_shell
// Function: Map the readouts from position caches to PEs.
// Uses half shell neighbor selection
///////////////////////////////////////////////////////////////////////////////

module position_cache_to_PE_mapping_half_shell
#(
	parameter NUM_CELLS          = 64, 
	parameter OFFSET_WIDTH       = 29, 
	parameter POS_CACHE_WIDTH    = 3*OFFSET_WIDTH, 
	parameter NUM_NEIGHBOR_CELLS = 13,
  parameter X_DIM              = 4,
  parameter Y_DIM              = 4,
  parameter Z_DIM              = 4
)
(
	input [NUM_CELLS-1:0][POS_CACHE_WIDTH-1:0] rd_nb_position,
	
	output [NUM_CELLS-1:0][NUM_NEIGHBOR_CELLS:0][POS_CACHE_WIDTH-1:0] rd_nb_position_splitted
);

genvar i,j,k,n;

`define H i*X_DIM*Y_DIM+j*X_DIM+k

localparam NX   = X_DIM;
localparam NY   = Y_DIM;
localparam NZ   = Z_DIM;
localparam NXY  = NX*NY;
localparam NXYZ = NX*NY*NZ;

generate
  for(i=0; i<Z_DIM; i++)begin: Z_loop
    for(j=0; j<Y_DIM; j++)begin: Y_loop
      for(k=0; k<X_DIM; k++)begin: X_loop
        for(n=0; n<=NUM_NEIGHBOR_CELLS; n++)begin: neighbor_loop
          case(n)
            0:begin
              assign rd_nb_position_splitted[`H][n] = rd_nb_position[`H];
            end
            1:begin
              if(k == NX-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXYZ-NX+1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 1)%NUM_CELLS];
            end
            2:begin
              if(k == 0 & j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXYZ-NXY+2*NX-1)%NUM_CELLS];
              else if(j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXYZ-NXY+NX-1)%NUM_CELLS];
              else if(k == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 2*NX-1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NX-1)%NUM_CELLS];
            end
            3:begin
              if(j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXYZ-NXY+NX)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NX)%NUM_CELLS];
            end
            4:begin
              if(k == NX-1 & j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXYZ-NXY+1)%NUM_CELLS];
              else if(j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXYZ-NXY+NX+1)%NUM_CELLS];
              else if(k == NX-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NX+1)%NUM_CELLS];
            end
            5:begin
              if(k == 0 & j == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 2*NXY-1)%NUM_CELLS];
              else if(j == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 2*NXY-NX-1)%NUM_CELLS];
              else if(k == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY-1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY-NX-1)%NUM_CELLS];
            end
            6:begin
              if(j == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 2*NXY-NX)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY-NX)%NUM_CELLS];
            end
            7:begin
              if(k == NX-1 & j == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 2*NXY-2*NX+1)%NUM_CELLS];
              else if(j == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 2*NXY-NX+1)%NUM_CELLS];
              else if(k == NX-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY-2*NX+1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY-NX+1)%NUM_CELLS];
            end
            8:begin
              if(k == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY+NX-1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY-1)%NUM_CELLS];
            end
            9:begin
              assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY)%NUM_CELLS];
            end
            10:begin
              if(k == NX-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY-NX+1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY+1)%NUM_CELLS];
            end
            11:begin
              if(k == 0 & j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 2*NX-1)%NUM_CELLS];
              else if(j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NX-1)%NUM_CELLS];
              else if(k == 0)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY+2*NX-1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY+NX-1)%NUM_CELLS];
            end
            12:begin
              if(j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NX)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY+NX)%NUM_CELLS];
            end
            13:begin
              if(k == NX-1 & j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + 1)%NUM_CELLS];
              else if(j == NY-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NX+1)%NUM_CELLS];
              else if(k == NX-1)
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY+1)%NUM_CELLS];
              else
                assign rd_nb_position_splitted[`H][n] = rd_nb_position[(`H + NXY+NX+1)%NUM_CELLS];
            end
          endcase
        end
      end
    end
  end
endgenerate

endmodule
