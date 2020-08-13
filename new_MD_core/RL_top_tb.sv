`timescale 1ns/1ns

//`define PRINT_PARTIAL_FORCES 1
`define FULL_DATA_DUMP 1

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


// Full data dump for one iteration

`ifdef FULL_DATA_DUMP
// text macros for module hierarchies
`define PE0 RL_top.PE_collection[0].single_PE
`define MUC RL_top.motion_update_control
`define MU `MUC.motion_update
`define MUX `MU.float2fixed_x
`define MUY `MU.float2fixed_y
`define MUZ `MU.float2fixed_z
`define FC0 RL_top.all_force_caches.force_caches[0].force_wb_controller
`define FD0 `PE0.force_distributor
`define RL0 `PE0.RL_LJ_Evaluation_Unit.RL_Force_Evaluation_Unit

`define PA00 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[0].Partial_Force_Acc
`define PA01 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[1].Partial_Force_Acc
`define PA02 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[2].Partial_Force_Acc
`define PA03 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[3].Partial_Force_Acc
`define PA04 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[4].Partial_Force_Acc
`define PA05 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[5].Partial_Force_Acc
`define PA06 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[6].Partial_Force_Acc


// Output files
// filters
integer file00, file01, file02, file03, file04, file05, file06, file07, file08, file09, file010, file011, file012, file013;
integer file_fdb0, file_fci0, file_fco0;
integer file_mu_pos0, file_mu_vel0;

initial begin
  file00  = $fopen("filter_0_0.dat", "w");
  file01  = $fopen("filter_0_1.dat", "w");
  file02  = $fopen("filter_0_2.dat", "w");
  file03  = $fopen("filter_0_3.dat", "w");
  file04  = $fopen("filter_0_4.dat", "w");
  file05  = $fopen("filter_0_5.dat", "w");
  file06  = $fopen("filter_0_6.dat", "w");
  file07  = $fopen("filter_0_7.dat", "w");
  file08  = $fopen("filter_0_8.dat", "w");
  file09  = $fopen("filter_0_9.dat", "w");
  file010 = $fopen("filter_0_10.dat", "w");
  file011 = $fopen("filter_0_11.dat", "w");
  file012 = $fopen("filter_0_12.dat", "w");
  file013 = $fopen("filter_0_13.dat", "w");

  file_fdb0 = $fopen("force_distributor_0_output.dat", "w");
  file_fci0 = $fopen("force_cache_0_input.dat", "w");
  file_fco0 = $fopen("force_cache_0_output.dat", "w");

  file_mu_pos0 = $fopen("mu_position_cell0.dat", "w");
  file_mu_vel0 = $fopen("mu_velocity_cell0.dat", "w");

  if(!file00 | !file01 | !file02 | !file03  | !file04  | !file05  | !file06  |
     !file07 | !file08 | !file09 | !file010 | !file011 | !file012 | !file013 |
     !file_fdb0 | !file_fci0 | !file_fco0
    )begin
    $display("Error opening output files.");
    $stop();
  end
end



// 1. values written to force cache
// 1.1 going out of the force distributor
always @(negedge clk)begin
  if(`FD0.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD0.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb0, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD0.wb_out[102:96],
        `FD0.wb_out[31:0], `FD0.wb_out[63:32], `FD0.wb_out[95:64]);
    end
    if(`FD0.start_wb)begin
      $fdisplay(file_fdb0, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD0.state.name() == "WB_REF")begin
    if(`FD0.wb_valid & `FD0.ready)begin
      $fdisplay(file_fdb0, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD0.wb_out[102:96], `FD0.wb_out[111:109], `FD0.wb_out[108:106],
        `FD0.wb_out[105:103], `FD0.wb_out[31:0], `FD0.wb_out[63:32], `FD0.wb_out[95:64]
      );
    end
    if(`FD0.ready & `FD0.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb0, "\n\nChange ref ID.\n");
    end
  end
end

// 1.2 Going into force cache
always @(negedge clk)begin
  if(`FC0.wr_enable & `FC0.force_to_cache != 96'd0)begin
    $fdisplay(file_fci0, "PID=%0d\t\t%x\t%x\t%x", `FC0.force_wr_addr,
      `FC0.force_to_cache[31:0], `FC0.force_to_cache[63:32], `FC0.force_to_cache[95:64]);
  end
end

// 2. values going into 7 partial force accumulators
localparam C1 = 3'b001;
localparam C2 = 3'b010;
localparam C3 = 3'b011;

//filter 0
always @(negedge clk)begin
  if(`PA00.in_input_valid & `PA00.particle_id_match & (`PA00.cell_id_match | `PA00.phase_change))begin
    if(`PA00.in_id.cell_id == {C2,C2,C2})begin //(222)
      $fdisplay(file00, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA00.in_id.cell_id == {C3,C1,C3})begin //(313)
      $fdisplay(file07, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
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
  else if(!`PA00.particle_id_match)begin
    $fdisplay(file00, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA00.in_id.particle);
    $fdisplay(file07, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA00.in_id.particle);
  end
end

//filter 1
always @(negedge clk)begin
  if(`PA01.in_input_valid & `PA01.particle_id_match & (`PA01.cell_id_match | `PA01.phase_change))begin
    if(`PA01.in_id.cell_id == {C2,C2,C3})begin //(223)
      $fdisplay(file01, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA01.in_id.cell_id == {C3,C2,C1})begin //(321)
      $fdisplay(file08, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
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
  else if(~`PA01.particle_id_match)begin
    $fdisplay(file01, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA01.in_id.particle);
    $fdisplay(file08, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA01.in_id.particle);
  end
end

//filter 2
always @(negedge clk)begin
  if(`PA02.in_input_valid & `PA02.particle_id_match & (`PA02.cell_id_match | `PA02.phase_change))begin
    if(`PA02.in_id.cell_id == {C2,C3,C1})begin //(231)
      $fdisplay(file02, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA02.in_id.cell_id == {C3,C2,C2})begin
      $fdisplay(file09, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
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
  else if(!`PA02.particle_id_match)begin
    $fdisplay(file02, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA02.in_id.particle);
    $fdisplay(file09, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA02.in_id.particle);
  end
end

//filter 3
always @(negedge clk)begin
  if(`PA03.in_input_valid & `PA03.particle_id_match & (`PA03.cell_id_match | `PA03.phase_change))begin
    if(`PA03.in_id.cell_id == {C2,C3,C2})begin //(232)
      $fdisplay(file03, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA03.in_id.cell_id == {C3,C2,C3})begin
      $fdisplay(file010, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
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
  else if(!`PA03.particle_id_match)begin
    $fdisplay(file03, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA03.in_id.particle);
    $fdisplay(file010, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA03.in_id.particle);
  end
end

//filter 4
always @(negedge clk)begin
  if(`PA04.in_input_valid & `PA04.particle_id_match & (`PA04.cell_id_match | `PA04.phase_change))begin
    if(`PA04.in_id.cell_id == {C2,C3,C3})begin //(233)
      $fdisplay(file04, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA04.in_id.cell_id == {C3,C3,C1})begin
      $fdisplay(file011, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
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
  else if(!`PA04.particle_id_match)begin
    $fdisplay(file04, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA04.in_id.particle);
    $fdisplay(file011, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA04.in_id.particle);
  end
end

//filter 5
always @(negedge clk)begin
  if(`PA05.in_input_valid & `PA05.particle_id_match & (`PA05.cell_id_match | `PA05.phase_change))begin
    if(`PA05.in_id.cell_id == {C3,C1,C1})begin //(311)
      $fdisplay(file05, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA05.in_id.cell_id == {C3,C3,C2})begin
      $fdisplay(file012, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
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
  else if(!`PA05.particle_id_match)begin
    $fdisplay(file05, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA05.in_id.particle);
    $fdisplay(file012, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA05.in_id.particle);
  end
end

//filter 6
always @(negedge clk)begin
  if(`PA06.in_input_valid & `PA06.particle_id_match & (`PA06.cell_id_match | `PA06.phase_change))begin
    if(`PA06.in_id.cell_id == {C3,C1,C2})begin //(312)
      $fdisplay(file06, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA06.in_id.cell_id == {C3,C3,C3})begin
      $fdisplay(file013, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
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
  else if(!`PA06.particle_id_match)begin
    $fdisplay(file06, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA06.in_id.particle);
    $fdisplay(file013, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA06.in_id.particle);
  end
end


// 3. values read from force cache for motion update
logic mu_started;
initial begin
  mu_started = 0;
  wait(RL_top.motion_update_start);
  mu_started = 1;
end

always @(negedge clk)begin
  if(`FC0.rd_enable)begin
    $fdisplay(file_fco0, "t=%0t\trd_addr=%0d", $time, `FC0.force_rd_addr);
  end
end

always @(`FC0.force_id_to_MU or `FC0.force_to_MU)begin
  if(mu_started)begin
    $fdisplay(file_fco0, "t=%0t\tID=%0d\t\t%x\t%x\t%x", $time, `FC0.force_id_to_MU,
      `FC0.force_to_MU[31:0], `FC0.force_to_MU[63:32], `FC0.force_to_MU[95:64]);
  end
end


// 4. values going out of motion update unit to position and velocity caches
always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b000_000_000)begin
    //time  diff_x(float) diff_y  diff_z  old_pos_x(fixed)  new_pos_x(fixed) pos_y pos_z
    $fdisplay(file_mu_pos0, "t=%0t\t\t%x\t%x\t%x\t\t%x\t%x\t%x",
    $time, `MUX.b, `MUY.b, `MUZ.b, `MUX.a, `MUY.a, `MUZ.a);
  end
end

always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b000_000_000)begin
    $fdisplay(file_mu_vel0, "t=%0t\t\t%x\t%x\t%x", $time, `MUC.out_velocity_data[31:0], 
    `MUC.out_velocity_data[63:32], `MUC.out_velocity_data[95:64]);
  end
end

// End simulation when motion update is done.
initial begin
  wait(`MUC.out_motion_update_done);
  #10;
  $display("Ending simulation.");
  $fclose(file00);
  $fclose(file01);
  $fclose(file02);
  $fclose(file03);
  $fclose(file04);
  $fclose(file05);
  $fclose(file06);
  $fclose(file07);
  $fclose(file08);
  $fclose(file09);
  $fclose(file010);
  $fclose(file011);
  $fclose(file012);
  $fclose(file013);
  $fclose(file_fdb0);
  $fclose(file_fci0);
  $fclose(file_fco0);
  $fclose(file_mu_pos0);
  $fclose(file_mu_vel0);
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
