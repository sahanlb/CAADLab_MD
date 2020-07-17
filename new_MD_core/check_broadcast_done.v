module check_broadcast_done
#(
	parameter PARTICLE_ID_WIDTH = 7
)
(
	input [PARTICLE_ID_WIDTH-1:0] particle_count, //number of particles in the cell
	input [PARTICLE_ID_WIDTH-1:0] particle_id, //currernt particle ID
	
	output broadcast_done
);

// There are a few cycles delay before particle number arrives (so number = 0 by default), but broadcast is not done
// It's possible that the particle count is not correct while beginning to process the next ref particle. 
// But as long as the particle number is greater than the number of cycles delayed (3), it's ok. 
assign broadcast_done = (particle_id > particle_count) & (particle_count != 0);

endmodule
