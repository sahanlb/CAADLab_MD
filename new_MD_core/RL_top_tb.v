`timescale 1ns/1ns

`define PRINT_PARTIAL_FORCES 1

module RL_top_tb;

parameter NUM_CELLS = 64; 
parameter NUM_PARTICLE_PER_CELL = 100; 
parameter OFFSET_WIDTH = 29; 
parameter DATA_WIDTH = 32;
parameter CELL_ID_WIDTH = 3;
parameter DECIMAL_ADDR_WIDTH = 2; 
parameter PARTICLE_ID_WIDTH = 7; 
parameter X_DIM = 4; 
parameter Y_DIM = 4; 
parameter Z_DIM = 4; 
parameter BODY_BITS = 8; 
parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH;
parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH; 
parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH; 
parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+PARTICLE_ID_WIDTH+1; 
parameter FORCE_DATA_WIDTH = FORCE_BUFFER_WIDTH-1; 
parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter POS_CACHE_WIDTH = 3*OFFSET_WIDTH; 
parameter VELOCITY_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter NUM_FILTER = 7; 
parameter ARBITER_MSB = 64; 				// 2^(NUM_FILTER-1)
parameter NUM_NEIGHBOR_CELLS = 13; 
parameter ALL_POSITION_WIDTH = (NUM_NEIGHBOR_CELLS+1)*POS_CACHE_WIDTH;

reg clk; 
reg rst; 
reg start;

// Output from PE
wire [NUM_CELLS-1:0] reading_done; 
wire [NUM_CELLS-1:0] back_pressure; 
wire [NUM_CELLS-1:0] filter_buffer_empty; 
wire [NUM_CELLS-1:0] force_valid;
wire force_valid_and;

always #1 clk <= ~clk;

initial begin
	clk <= 1;
	rst <= 1;
	start <= 0;
	
	#10
	rst <= 0;
	
	#8
	start <= 1;
	
	#100
	start <= 0;
end


// Stop simulation after motion update is completed in the first iteration
initial begin
  wait(RL_top.MU_done);
  #10000;
  $stop();
end


`ifdef PRINT_PARTIAL_FORCES
// Print partial force values
localparam C1 = 3'b001;
localparam C2 = 3'b010;
localparam C3 = 3'b011;

integer file0, file1, file2, file3, file4, file5, file6, file7, file8, file9, file10, file11, file12, file13;

initial begin
  file0  = $fopen("filter0.dat", "w");
  file1  = $fopen("filter1.dat", "w");
  file2  = $fopen("filter2.dat", "w");
  file3  = $fopen("filter3.dat", "w");
  file4  = $fopen("filter4.dat", "w");
  file5  = $fopen("filter5.dat", "w");
  file6  = $fopen("filter6.dat", "w");
  file7  = $fopen("filter7.dat", "w");
  file8  = $fopen("filter8.dat", "w");
  file9  = $fopen("filter9.dat", "w");
  file10 = $fopen("filter10.dat", "w");
  file11 = $fopen("filter11.dat", "w");
  file12 = $fopen("filter12.dat", "w");
  file13 = $fopen("filter13.dat", "w");

  if(!file0 | !file1 | !file2 | !file3  | !file4  | !file5  | !file6  |
     !file7 | !file8 | !file9 | !file10 | !file11 | !file12 | !file13 )begin
    $display("Error opening output files.");
    $stop();
  end

end

`define RL0 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.RL_Force_Evaluation_Unit
`define PA0 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[0].Partial_Force_Acc
`define PA1 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[1].Partial_Force_Acc
`define PA2 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[2].Partial_Force_Acc
`define PA3 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[3].Partial_Force_Acc
`define PA4 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[4].Partial_Force_Acc
`define PA5 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[5].Partial_Force_Acc
`define PA6 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[6].Partial_Force_Acc

//filter 0
always @(negedge clk)begin
  if(`PA0.in_input_valid & `PA0.particle_id_match & (`PA0.cell_id_match | `PA0.phase_change))begin
    if(`PA0.in_id.cell_id == {C2,C2,C2})begin //(222)
      $fdisplay(file0, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA0.in_id.cell_id == {C3,C1,C3})begin //(313)
      $fdisplay(file7, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 0 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 1
always @(negedge clk)begin
  if(`PA1.in_input_valid & `PA1.particle_id_match & (`PA1.cell_id_match | `PA1.phase_change))begin
    if(`PA1.in_id.cell_id == {C2,C2,C3})begin //(223)
      $fdisplay(file1, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA1.in_id.cell_id == {C3,C2,C1})begin //(321)
      $fdisplay(file8, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 1 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 2
always @(negedge clk)begin
  if(`PA2.in_input_valid & `PA2.particle_id_match & (`PA2.cell_id_match | `PA2.phase_change))begin
    if(`PA2.in_id.cell_id == {C2,C3,C1})begin //(231)
      $fdisplay(file2, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA2.in_id.cell_id == {C3,C2,C2})begin
      $fdisplay(file9, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 2 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 3
always @(negedge clk)begin
  if(`PA3.in_input_valid & `PA3.particle_id_match & (`PA3.cell_id_match | `PA3.phase_change))begin
    if(`PA3.in_id.cell_id == {C2,C3,C2})begin //(232)
      $fdisplay(file3, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA3.in_id.cell_id == {C3,C2,C3})begin
      $fdisplay(file10, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 3 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 4
always @(negedge clk)begin
  if(`PA4.in_input_valid & `PA4.particle_id_match & (`PA4.cell_id_match | `PA4.phase_change))begin
    if(`PA4.in_id.cell_id == {C2,C3,C3})begin //(233)
      $fdisplay(file4, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA4.in_id.cell_id == {C3,C3,C1})begin
      $fdisplay(file11, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 4 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 5
always @(negedge clk)begin
  if(`PA5.in_input_valid & `PA5.particle_id_match & (`PA5.cell_id_match | `PA5.phase_change))begin
    if(`PA5.in_id.cell_id == {C3,C1,C1})begin //(311)
      $fdisplay(file5, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA5.in_id.cell_id == {C3,C3,C2})begin
      $fdisplay(file12, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 5 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 6
always @(negedge clk)begin
  if(`PA6.in_input_valid & `PA6.particle_id_match & (`PA6.cell_id_match | `PA6.phase_change))begin
    if(`PA6.in_id.cell_id == {C3,C1,C2})begin //(312)
      $fdisplay(file6, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA6.in_id.cell_id == {C3,C3,C3})begin
      $fdisplay(file13, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 6 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end


// Stop simulation after one ref_id is completed
initial begin
  wait(`PA0.start_wb);
  $display("Start WB issued by partial acumulator 0 at t=%0t", $time);
  #10;
  $stop();
end

`endif



RL_top
#(
	.NUM_CELLS(NUM_CELLS),
	.NUM_PARTICLE_PER_CELL(NUM_PARTICLE_PER_CELL),
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.X_DIM(X_DIM),
	.Y_DIM(Y_DIM),
	.Z_DIM(Z_DIM),
	.BODY_BITS(BODY_BITS),
	.ID_WIDTH(ID_WIDTH),
	.FULL_CELL_ID_WIDTH(FULL_CELL_ID_WIDTH),
	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
	.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH),
	.FORCE_DATA_WIDTH(FORCE_DATA_WIDTH),
	.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
	.POS_CACHE_WIDTH(POS_CACHE_WIDTH),
	.VELOCITY_CACHE_WIDTH(VELOCITY_CACHE_WIDTH),
	.NUM_FILTER(NUM_FILTER),
	.ARBITER_MSB(ARBITER_MSB),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.ALL_POSITION_WIDTH(ALL_POSITION_WIDTH)
)
RL_top
(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.reading_done(reading_done),
	.back_pressure(back_pressure),
	.filter_buffer_empty(filter_buffer_empty),
	.force_valid(force_valid),
	.force_valid_and(force_valid_and)
);

endmodule
