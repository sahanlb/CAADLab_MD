import md_pkg::*;

module all_velocity_caches(
	input clk,
	input rst,
	input Motion_Update_enable,
	input particle_id_t MU_rd_addr,
	input data_tuple_t MU_wr_data,
	input full_cell_id_t MU_dst_cell,
	input MU_wr_data_valid,
	input MU_rden,
	
	output data_tuple_t [NUM_CELLS-1:0] velocity_data_out
);

genvar i,j,k;

// Instantiate velocity caches
generate
  for()begin: z_dim
    for()begin: y_dim
      for()begin: x_dim

      end
    end
  end
endgenerate


	Velocity_Cache_1_1_1
	#(
		.DATA_WIDTH(DATA_WIDTH),
		.PARTICLE_NUM(NUM_PARTICLE_PER_CELL),
		.ADDR_WIDTH(PARTICLE_ID_WIDTH),
		.CELL_ID_WIDTH(CELL_ID_WIDTH),
		.CELL_X(4'd1),
		.CELL_Y(4'd1),
		.CELL_Z(4'd1)
	)
	Velocity_Cache_1_1_1
	(
		.clk(clk),
		.rst(rst),
		.motion_update_enable(Motion_Update_enable),				// Keep this signal as high during the motion update process
		.in_read_address(MU_rd_addr),
		.in_data(MU_wr_data),
		.in_data_dst_cell(MU_dst_cell),				// The destination cell for the incoming data
		.in_data_valid(MU_wr_data_valid),// Signify if the new incoming data is valid
		.in_rden(MU_rden),
		.out_particle_info(velocity_data_out[1*3*DATA_WIDTH-1:0*3*DATA_WIDTH])
	);
	
endmodule
