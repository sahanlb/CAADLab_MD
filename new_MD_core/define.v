// defines

`define WINDOWS_PATH 1

// Text macro to instantiate position caches
`define POS_CACHE_INSTANCE(XPOS, YPOS, ZPOS) \
Pos_Cache_x_y_z                              \
#(                                           \
      .DATA_WIDTH(DATA_WIDTH),               \
      .PARTICLE_NUM(NUM_PARTICLE_PER_CELL),  \
      .ADDR_WIDTH(PARTICLE_ID_WIDTH),        \
      .CELL_ID_WIDTH(CELL_ID_WIDTH),         \
      .CELL_X(XPOS),                         \
      .CELL_Y(YPOS),                         \
      .CELL_Z(ZPOS),                         \
      .POSITION_FILE(`"./pos_init/hex_files/cell_ini_file_``XPOS``_``YPOS``_``ZPOS``.hex`") \
)                                                                      \
cell_``XPOS``_``YPOS``_``ZPOS``                                        \
(                                                                      \
      .clk(clk),                                                       \
      .rst(rst),                                                       \
      .motion_update_enable(Motion_Update_enable),                     \
      .in_read_address(Motion_Update_enable ? MU_rd_addr : rd_addr),   \
      .in_data(MU_wr_data),                                            \
      .in_data_dst_cell(MU_dst_cell),                                  \
      .in_data_valid(MU_wr_data_valid),                                \
      .in_rden(Motion_Update_enable ? MU_rden : 1'b1),                 \
      .out_particle_info(pos_data_out[(25*(ZPOS-1)+5*(YPOS-1)+(XPOS-1))])\
);


// Text macro to instantiate velocity caches
`define VELOCITY_CACHE_INSTANCE(ZPOS, YPOS, XPOS)                          \
Velocity_Cache_z_y_x                                                       \
#(                                                                         \
  .DATA_WIDTH(DATA_WIDTH),                                                 \
  .PARTICLE_NUM(NUM_PARTICLE_PER_CELL),                                    \
  .ADDR_WIDTH(PARTICLE_ID_WIDTH),                                          \
  .CELL_ID_WIDTH(CELL_ID_WIDTH),                                           \
  .CELL_X(XPOS),                                                           \
  .CELL_Y(YPOS),                                                           \
  .CELL_Z(ZPOS),                                                           \
  .VELOCITY_FILE("")                                                       \
)                                                                          \
Velocity_Cache_``ZPOS``_``YPOS``_``XPOS``                                  \
(                                                                          \
	.clk(clk),                                                               \
	.rst(rst),                                                               \
	.motion_update_enable(Motion_Update_enable),                             \
	.in_read_address(MU_rd_addr),                                            \
	.in_data(MU_wr_data),                                                    \
	.in_data_dst_cell(MU_dst_cell),                                          \
	.in_data_valid(MU_wr_data_valid),                                        \
	.in_rden(MU_rden),                                                       \
	.out_particle_info(velocity_data_out[(25*(ZPOS-1)+5*(YPOS-1)+(XPOS-1))]) \
);

