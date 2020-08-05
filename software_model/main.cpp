#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <string>
#include "main.h"
using namespace std;

int main() {
	int i, j, k;

#pragma region DeclareMatrices
	// Declare a raw position data matrix (2d)
	float** raw_pos_data;
	raw_pos_data = new float* [3];
	for (i = 0; i < 3; i++) {
		raw_pos_data[i] = new float[TOTAL_PARTICLE];
	}

	// Declare a position data matrix for shifted data (2d)
	float** pos_data;
	pos_data = new float* [3];
	for (i = 0; i < 3; i++) {
		pos_data[i] = new float[TOTAL_PARTICLE];
	}

	/* Record the history of energy, 1: LJ potential, 2: Kinectic energy, 3: Total energy*/
	double* energy_data_history;
	energy_data_history = new double [3];

	// Declare a counter matrix to track the # of particles in each cell (3d)
	int*** particle_in_cell_counter;
	particle_in_cell_counter = new int** [CELL_COUNT_X];
	for (i = 0; i < CELL_COUNT_X; i++) {
		particle_in_cell_counter[i] = new int* [CELL_COUNT_Y];
		for (j = 0; j < CELL_COUNT_Y; j++) {
			particle_in_cell_counter[i][j] = new int[CELL_COUNT_Z];
		}
	}


	// Declare a matrix to record the status of each particle in each cell (3d)
	float*** cell_particle;
	cell_particle = new float** [12];
	for (i = 0; i < 12; i++) {
		cell_particle[i] = new float* [CELL_COUNT_TOTAL];
		for (j = 0; j < CELL_COUNT_TOTAL; j++) {
			cell_particle[i][j] = new float[CELL_PARTICLE_MAX];
		}
	}

	// Declare a temporary counter matrix to track the # of particles in each cell (3d)
	int*** tmp_particle_in_cell_counter;
	tmp_particle_in_cell_counter = new int** [CELL_COUNT_X];
	for (i = 0; i < CELL_COUNT_X; i++) {
		tmp_particle_in_cell_counter[i] = new int* [CELL_COUNT_Y];
		for (j = 0; j < CELL_COUNT_Y; j++) {
			tmp_particle_in_cell_counter[i][j] = new int[CELL_COUNT_Z];
		}
	}

	// Declare a temporary matrix to record the status of each particle in each cell (3d)
	float*** tmp_cell_particle;
	tmp_cell_particle = new float** [12];
	for (i = 0; i < 12; i++) {
		tmp_cell_particle[i] = new float* [CELL_COUNT_TOTAL];
		for (j = 0; j < CELL_COUNT_TOTAL; j++) {
			tmp_cell_particle[i][j] = new float[CELL_PARTICLE_MAX];
		}
	}

  /***************/
  //cout << "check 1" << endl;
  /***************/

	// Declare a matrix to record the status of particles to be sent to the filters (3d)
	/* Hold all the particles that need to send to each filter to process, 
	   1:x; 2:y; 3:z; 4-6:cell_ID x,y,z; 7: particle_in_cell_index
	*/
	float*** filter_input_particle_reservoir;
	filter_input_particle_reservoir = new float** [7];
	for (i = 0; i < 7; i++) {
		// the factor 2 is because each filter can be in charge of 2 cells
		filter_input_particle_reservoir[i] = new float* [NUM_FILTER];
		for (j = 0; j < NUM_FILTER; j++) {
			filter_input_particle_reservoir[i][j] = new float[2 * CELL_PARTICLE_MAX];
		}
	}


	// Declare a matrix to record the number of reference particles to be evaluated by each filter (2d)
	/* Record how many reference particles each filter need to evaluate: 
	   1: total particle this filter need to process; 
	   2: # of particles from 1st cell; 
	   3: # of particles from 2nd cell
	*/
	float** filter_input_particle_num;
	filter_input_particle_num = new float* [3];
	for (i = 0; i < 3; i++) {
		filter_input_particle_num[i] = new float[NUM_FILTER];
	}


	// Declare arrays to represent the coordinates of cells, and initialize (1d)
	// Indices start from 0
	int* HOME_CELL_X_RANGE;
	int* HOME_CELL_Y_RANGE;
	int* HOME_CELL_Z_RANGE;
	HOME_CELL_X_RANGE = new int[CELL_COUNT_X];
	HOME_CELL_Y_RANGE = new int[CELL_COUNT_Y];
	HOME_CELL_Z_RANGE = new int[CELL_COUNT_Z];
	for (i = 0; i < CELL_COUNT_X; i++) {
		HOME_CELL_X_RANGE[i] = i;
	}
	for (i = 0; i < CELL_COUNT_Y; i++) {
		HOME_CELL_Y_RANGE[i] = i;
	}
	for (i = 0; i < CELL_COUNT_Z; i++) {
		HOME_CELL_Z_RANGE[i] = i;
	}

	// Declare interpolation tables
	float* c0_vdw_list_14;
	c0_vdw_list_14 = new float[INTERPOLATION_TABLE_SIZE];
	float* c1_vdw_list_14;
	c1_vdw_list_14 = new float[INTERPOLATION_TABLE_SIZE];
	float* c0_vdw_list_8;
	c0_vdw_list_8 = new float[INTERPOLATION_TABLE_SIZE];
	float* c1_vdw_list_8;
	c1_vdw_list_8 = new float[INTERPOLATION_TABLE_SIZE];
	float* c0_vdw_list_12;
	c0_vdw_list_12 = new float[INTERPOLATION_TABLE_SIZE];
	float* c1_vdw_list_12;
	c1_vdw_list_12 = new float[INTERPOLATION_TABLE_SIZE];
	float* c0_vdw_list_6;
	c0_vdw_list_6 = new float[INTERPOLATION_TABLE_SIZE];
	float* c1_vdw_list_6;
	c1_vdw_list_6 = new float[INTERPOLATION_TABLE_SIZE];
	float* c2_vdw_list_14;
	float* c2_vdw_list_12;
	float* c2_vdw_list_8;
	float* c2_vdw_list_6;
	float* c3_vdw_list_14;
	float* c3_vdw_list_8;
	float* c3_vdw_list_12;
	float* c3_vdw_list_6;
	if (INTERPOLATION_ORDER > 1) {
		c2_vdw_list_14 = new float[INTERPOLATION_TABLE_SIZE];
		c2_vdw_list_8 = new float[INTERPOLATION_TABLE_SIZE];
		c2_vdw_list_12 = new float[INTERPOLATION_TABLE_SIZE];
		c2_vdw_list_6 = new float[INTERPOLATION_TABLE_SIZE];
	}
	if (INTERPOLATION_ORDER > 2) {
		c3_vdw_list_14 = new float[INTERPOLATION_TABLE_SIZE];
		c3_vdw_list_8 = new float[INTERPOLATION_TABLE_SIZE];
		c3_vdw_list_12 = new float[INTERPOLATION_TABLE_SIZE];
		c3_vdw_list_6 = new float[INTERPOLATION_TABLE_SIZE];
	}

  
  // Declare array to hold the calculated neighbor cell IDs for a given iteration
  int neighbor_cell_id[14];

#pragma endregion
#pragma region Initialize

	string input_file_path = get_input_path(INPUT_FILE_NAME);							// Get the input file path

	cout << "*** Start reading data from input file:" << " ***" << endl;
	cout << input_file_path << endl;
	read_initial_input(input_file_path, raw_pos_data);							// Read the initial position
	cout << "*** Particle data loading finished ***\n" << endl;


	string OUTPUT_ENERGY_FILE_PATH;
	if (ENABLE_OUTPUT_ENERGY_FILE) {
		OUTPUT_ENERGY_FILE_PATH = get_energy_output_path();		// Set the output path
	}
	ofstream output_file;
	output_file.open(OUTPUT_ENERGY_FILE_PATH, ofstream::app);

	shift_to_first_quadrant(raw_pos_data, pos_data);					// Shift the positions to the 1st quadrant
  /******/
  //cout << "check 2" << endl;
  /******/

	set_to_zeros_3d_int(particle_in_cell_counter, 
		CELL_COUNT_X, CELL_COUNT_Y, CELL_COUNT_Z);						// Initialize the particle counter to 0
  /******/
  //cout << "check 3" << endl;
  /******/

	//set_to_zeros_3d(filter_input_particle_reservoir, 7, NUM_FILTER, 2 * CELL_PARTICLE_MAX);		// Initialize the filter reservoir to 0
	set_to_zeros_3d(filter_input_particle_reservoir, 2*CELL_PARTICLE_MAX, NUM_FILTER, 7);		// Initialize the filter reservoir to 0
  /******/
  //cout << "check 4" << endl;
  /******/

	//set_to_zeros_3d(cell_particle, 12, CELL_COUNT_TOTAL, CELL_PARTICLE_MAX);		// Initialize the particle-cell data matrix to 0
	set_to_zeros_3d(cell_particle, CELL_PARTICLE_MAX, CELL_COUNT_TOTAL, 12);		// Initialize the particle-cell data matrix to 0
  /******/
  //cout << "check 5" << endl;
  /******/

	cout << "*** Start mapping particles to cells ***" << endl;
	map_to_cells(pos_data, cell_particle, particle_in_cell_counter);	// Map the particles to cells

  // Print particle counts
  if(DEBUG){
    cout << "Print particle count" << endl;
    print_int_3d(particle_in_cell_counter, CELL_COUNT_X, CELL_COUNT_Y, CELL_COUNT_Z);
    //return 0;
  }

	/* Start loading interpolation index data */
	string file_0 = get_input_path("c0_14.txt");
	read_interpolation(file_0, c0_vdw_list_14);
	string file_1 = get_input_path("c1_14.txt");
	read_interpolation(file_1, c1_vdw_list_14);
	string file_4 = get_input_path("c0_8.txt");
	read_interpolation(file_4, c0_vdw_list_8);
	string file_5 = get_input_path("c1_8.txt");
	read_interpolation(file_5, c1_vdw_list_8);
	string file_8 = get_input_path("c0_12.txt");
	read_interpolation(file_8, c0_vdw_list_12);
	string file_9 = get_input_path("c1_12.txt");
	read_interpolation(file_9, c1_vdw_list_12);
	string file_12 = get_input_path("c0_6.txt");
	read_interpolation(file_12, c0_vdw_list_6);
	string file_13 = get_input_path("c1_6.txt");
	read_interpolation(file_13, c1_vdw_list_6);
	if (INTERPOLATION_ORDER > 1) {
		string file_2 = get_input_path("c2_14.txt");
		read_interpolation(file_2, c2_vdw_list_14);
		string file_6 = get_input_path("c2_8.txt");
		read_interpolation(file_6, c2_vdw_list_8);
		string file_10 = get_input_path("c2_12.txt");
		read_interpolation(file_10, c2_vdw_list_12);
		string file_14 = get_input_path("c2_6.txt");
		read_interpolation(file_14, c2_vdw_list_6);
	}
	if (INTERPOLATION_ORDER > 2) {
		string file_3 = get_input_path("c3_14.txt");
		read_interpolation(file_3, c3_vdw_list_14);
		string file_7= get_input_path("c3_8.txt");
		read_interpolation(file_7, c3_vdw_list_8);
		string file_11 = get_input_path("c3_12.txt");
		read_interpolation(file_11, c3_vdw_list_12);
		string file_15 = get_input_path("c3_6.txt");
		read_interpolation(file_15, c3_vdw_list_6);
	}
#pragma endregion
#pragma region FullSimulation
	int sim_iter;
	int home_cell_x, home_cell_y, home_cell_z;
	int nb_cell_x, nb_cell_y, nb_cell_z;
	int filter_id, nb_cell_id;
	int tmp_particle_num, tmp_particle_num_1, tmp_particle_num_2;
	int filter_process_particle_max;
	int ref_particle_index, nb_particle_index;
	int tmp_counter_particles_within_cutoff;
	int seg_index;
	bool ENABLE_ENERGY_EVALUATION;
	float ref_pos_x, ref_pos_y, ref_pos_z;
	float nb_pos_x, nb_pos_y, nb_pos_z;
	float tmp_force_acc_x, tmp_force_acc_y, tmp_force_acc_z;
	float tmp_potential_acc;
	float tmp_nb_force_x, tmp_nb_force_y, tmp_nb_force_z;
	float dx, dy, dz, r2;
	double SIMULATION_TIME_STEP = 2E-15;
	for (sim_iter = 0; sim_iter < SIMULATION_TIMESTEP; sim_iter++) {

		if (sim_iter % ENERGY_EVALUATION_STEPS == 0) {
			ENABLE_ENERGY_EVALUATION = 1;
		}
		else {
			ENABLE_ENERGY_EVALUATION = 0;
		}

		// Each cell as home cell for once
		for (home_cell_x = 0; home_cell_x < CELL_COUNT_X; home_cell_x++) {
			for (home_cell_y = 0; home_cell_y < CELL_COUNT_Y; home_cell_y++) {
				for (home_cell_z = 0; home_cell_z < CELL_COUNT_Z; home_cell_z++) {
					// Generate input particle pairs
					// In the software model filters are processed in series, and we iterate through the home cell particles,
					// only one filter populated with home cell particles suffice. Reference particles are from neighbor cells 
					// and home cell itself.
					// filter_input_particle_num data structure is repurposed to save the number of particles in neighbor cells 
					// from which the reference particles are selected.
					if (ENABLE_PRINT_DETAIL_MESSAGE) {
						cout << "*** Start processing home cell: " << home_cell_x << home_cell_y << home_cell_z << " ***" << endl;
					}


					for (filter_id = 0; filter_id < NUM_FILTER; filter_id++) {
						switch (filter_id) // POSSIBLE ACCELERATION: USE MPI,
						{
#pragma region Case_0
						case 0: // Process home cell (222), neighbor cell is itself

							// Home cell itself is the neighbor cell
							nb_cell_id = cell_index_calculator(home_cell_x, home_cell_y, home_cell_z);
              neighbor_cell_id[filter_id] = nb_cell_id;

							// Get the # of particles
							tmp_particle_num = particle_in_cell_counter[home_cell_z][home_cell_y][home_cell_x];

							// Assign the particles from neighbor cell(home cell in this case) to reservoir
							for (i = 0; i < 3; i++) {
								for (j = 0; j < tmp_particle_num; j++) {
									filter_input_particle_reservoir[i][filter_id][j] =
										cell_particle[i][nb_cell_id][j];
								}
							}

							// Assign the particles ID
							for (i = 0; i < tmp_particle_num; i++) {
								filter_input_particle_reservoir[3][filter_id][i] = home_cell_x;
								filter_input_particle_reservoir[4][filter_id][i] = home_cell_y;
								filter_input_particle_reservoir[5][filter_id][i] = home_cell_z;
								filter_input_particle_reservoir[6][filter_id][i] = i;		// Particle index in current cell
							}


							// Get neighbor cell indices
							// Other neighbor cell processed by filter 0 is (3,1,3)
							if(home_cell_x == CELL_COUNT_X-1){
                nb_cell_x = 0;
              }
              else{
                nb_cell_x = home_cell_x + 1;
              }
              if(home_cell_y == 0){
                nb_cell_y = CELL_COUNT_Y - 1;
              }
              else{
                nb_cell_y = home_cell_y - 1;
              }
							if (home_cell_z == CELL_COUNT_Z - 1) {
								nb_cell_z = 0;
							}
							else {
								nb_cell_z = home_cell_z + 1;
							}

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id + NUM_FILTER] = nb_cell_id;


              //particle count for the second cell
              tmp_particle_num_2 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];


							filter_input_particle_num[0][filter_id] = (tmp_particle_num > tmp_particle_num_2) ? tmp_particle_num : tmp_particle_num_2;
							filter_input_particle_num[1][filter_id] = tmp_particle_num;
							filter_input_particle_num[2][filter_id] = tmp_particle_num_2;


							if (ENABLE_PRINT_DETAIL_MESSAGE) {
								cout << "*** Filter 0 assigned particles. ***" << endl;
								cout << tmp_particle_num << " particles in cell (222)" << endl;
								cout << tmp_particle_num_2 << " particles in cell (313)" << endl;
							}
							break;
#pragma endregion
#pragma region Case_1
						case 1: // Process cells (223) and (321)

							// Get neighbor cell indices (223)
							if (home_cell_x == CELL_COUNT_X - 1) {
								nb_cell_x = 0;
							}
							else {
								nb_cell_x = home_cell_x + 1;
							}
							nb_cell_y = home_cell_y;
							nb_cell_z = home_cell_z;

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id] = nb_cell_id;

							// Get the # of particles in cell (223)
							tmp_particle_num_1 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];


							// Get neighbor cell indices (321)
							if(home_cell_x == 0){
                nb_cell_x = CELL_COUNT_X - 1;
              }
              else{
                nb_cell_x = home_cell_x - 1;
              }
              nb_cell_y = home_cell_y;
              if(home_cell_z == CELL_COUNT_Z-1){
                nb_cell_z = 0;
              }
              else{
                nb_cell_z = home_cell_z + 1;
              }

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id + NUM_FILTER] = nb_cell_id;

							// Get the # of particles in cell (321)
							tmp_particle_num_2 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];


							filter_input_particle_num[0][filter_id] = (tmp_particle_num_1 > tmp_particle_num_2) ? tmp_particle_num_1 : tmp_particle_num_2;
							filter_input_particle_num[1][filter_id] = tmp_particle_num_1;
							filter_input_particle_num[2][filter_id] = tmp_particle_num_2;

							if (ENABLE_PRINT_DETAIL_MESSAGE) {
								cout << "*** Filter 1 assigned particles. ***" << endl;
								cout << tmp_particle_num_1 << " particles in the cell (223)" << endl;
								cout << tmp_particle_num_2 << " particles in the cell (321)" << endl;
							}
							break;
#pragma endregion						
#pragma region Case_2
						case 2: // Process cell (231), (322)

							// Process the 1st cell
							if(home_cell_x == 0){
                nb_cell_x = CELL_COUNT_X - 1;
              }
              else{
                nb_cell_x = home_cell_x - 1;
              }
              if(home_cell_y == CELL_COUNT_Y-1){
                nb_cell_y = 0;
              }
              else{
                nb_cell_y = home_cell_y + 1;
              }      
							nb_cell_z = home_cell_z;

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id] = nb_cell_id;

							// Get the # of particles in the current evaluated neighbor cell
							tmp_particle_num_1 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];

							// Process the 2nd cell (322)
							nb_cell_x = home_cell_x;
							nb_cell_y = home_cell_y;
              if(home_cell_z == CELL_COUNT_Z-1){
                nb_cell_z = 0;
              }
              else{
                nb_cell_z = home_cell_z + 1;
              }

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id + NUM_FILTER] = nb_cell_id;

							// Get the # of particles in both evaluated neighbor cells
							tmp_particle_num_2 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];

							filter_input_particle_num[0][filter_id] = (tmp_particle_num_1 > tmp_particle_num_2) ? tmp_particle_num_1 : tmp_particle_num_2;
							filter_input_particle_num[1][filter_id] = tmp_particle_num_1;
							filter_input_particle_num[2][filter_id] = tmp_particle_num_2;


							if (ENABLE_PRINT_DETAIL_MESSAGE) {
								cout << "*** Filter 2 assigned particles. ***" << endl;
								cout << tmp_particle_num_1 << " particles in the 1st cell (231)" << endl;
								cout << tmp_particle_num_2 << " particles in the 2nd cell (322)" << endl;
							}
							break;
#pragma endregion
#pragma region Case_3
						case 3: // Process cell (232) and (323)

							// Process the 1st cell
							nb_cell_x = home_cell_x;
							if (home_cell_y == CELL_COUNT_Y - 1) {
								nb_cell_y = 0;
							}
							else {
								nb_cell_y = home_cell_y + 1;
							}
							nb_cell_z = home_cell_z;

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id] = nb_cell_id;

							// Get the # of particles in the current evaluated neighbor cell
							tmp_particle_num_1 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];


							// Process the 2nd cell (323)
							if (home_cell_x == CELL_COUNT_X - 1) {
								nb_cell_x = 0;
							}
							else {
								nb_cell_x = home_cell_x + 1;
							}
							nb_cell_y = home_cell_y;
							if (home_cell_z == CELL_COUNT_Z-1) {
								nb_cell_z = 0;
							}
							else {
								nb_cell_z = home_cell_z + 1;
							}

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id + NUM_FILTER] = nb_cell_id;

							// Get the # of particles in both evaluated neighbor cells
							tmp_particle_num_2 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];

							filter_input_particle_num[0][filter_id] = (tmp_particle_num_1 > tmp_particle_num_2) ? tmp_particle_num_1 : tmp_particle_num_2;
							filter_input_particle_num[1][filter_id] = tmp_particle_num_1;
							filter_input_particle_num[2][filter_id] = tmp_particle_num_2;
							
              if (ENABLE_PRINT_DETAIL_MESSAGE) {
								cout << "*** Filter 3 assigned particles. ***" << endl;
								cout << tmp_particle_num_1 << " particles in the 1st cell (232)" << endl;
								cout << tmp_particle_num_2 << " particles in the 2nd cell (323)" << endl;
							}
							break;
#pragma endregion
#pragma region Case_4
						case 4: // Process cell (233) (331)

							// Process the 1st cell (233)
							if (home_cell_x == CELL_COUNT_X-1) {
								nb_cell_x = 0;
							}
							else {
								nb_cell_x = home_cell_x + 1;
							}
							if (home_cell_y == CELL_COUNT_Y-1) {
								nb_cell_y = 0;
							}
							else {
								nb_cell_y = home_cell_y + 1;
							}
							nb_cell_z = home_cell_z;

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id] = nb_cell_id;

							// Get the # of particles in the current evaluated neighbor cell
							tmp_particle_num_1 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];


							// Process the 2nd cell (331)
							if (home_cell_x == 0) {
								nb_cell_x = CELL_COUNT_X - 1;
							}
							else {
								nb_cell_x = home_cell_x - 1;
							}
							if (home_cell_y == CELL_COUNT_Y-1) {
								nb_cell_y = 0;
							}
							else {
								nb_cell_y = home_cell_y + 1;
							}
							if (home_cell_z == CELL_COUNT_Z-1) {
								nb_cell_z = 0;
							}
							else {
								nb_cell_z = home_cell_z + 1;
							}

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id + NUM_FILTER] = nb_cell_id;

							// Get the # of particles in both evaluated neighbor cells
							tmp_particle_num_2 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];

							filter_input_particle_num[0][filter_id] = (tmp_particle_num_1 > tmp_particle_num_2) ? tmp_particle_num_1 : tmp_particle_num_2;
							filter_input_particle_num[1][filter_id] = tmp_particle_num_1;
							filter_input_particle_num[2][filter_id] = tmp_particle_num_2;

							if (ENABLE_PRINT_DETAIL_MESSAGE) {
								cout << "*** Filter 4 assigned particles. ***" << endl;
								cout << tmp_particle_num_1 << " particles in the 1st cell (233)" << endl;
								cout << tmp_particle_num_2 << " particles in the 2nd cell (331)" << endl;
							}
							break;
#pragma endregion
#pragma region Case_5
						case 5: // Process cell (311), (332)

							// Process the 1st cell (311)
							if (home_cell_x == 0) {
								nb_cell_x = CELL_COUNT_X - 1;
							}
							else {
								nb_cell_x = home_cell_x - 1;
							}
              if(home_cell_y == 0){
                nb_cell_y = CELL_COUNT_Y - 1;
              }
              else{
                nb_cell_y = home_cell_y - 1;
              }
							if (home_cell_z == CELL_COUNT_Z-1) {
								nb_cell_z = 0;
							}
							else {
								nb_cell_z = home_cell_z + 1;
							}

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id] = nb_cell_id;

							// Get the # of particles in the current evaluated neighbor cell
							tmp_particle_num_1 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];


							// Process the 2nd cell (332)
							nb_cell_x = home_cell_x;
              if(home_cell_y == CELL_COUNT_Y-1){
                nb_cell_y = 0;
              }
              else{
                nb_cell_y = home_cell_y + 1;
              }
              if(home_cell_z == CELL_COUNT_Z-1){
                nb_cell_z = 0;
              }
              else{
                nb_cell_z = home_cell_z + 1;
              }

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id + NUM_FILTER] = nb_cell_id;

							// Get the # of particles in both evaluated neighbor cells
							tmp_particle_num_2 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];

							filter_input_particle_num[0][filter_id] = (tmp_particle_num_1 > tmp_particle_num_2) ? tmp_particle_num_1 : tmp_particle_num_2;
							filter_input_particle_num[1][filter_id] = tmp_particle_num_1;
							filter_input_particle_num[2][filter_id] = tmp_particle_num_2;

							if (ENABLE_PRINT_DETAIL_MESSAGE) {
								cout << "*** Filter 5 assigned particles. ***" << endl;
								cout << tmp_particle_num_1 << " particles in the 1st cell (311)" << endl;
								cout << tmp_particle_num_2 << " particles in the 2nd cell (332)" << endl;
							}
							break;
#pragma endregion
#pragma region Case_6
						case 6: // Process cell (312), (333)

							// Process the 1st cell (312)
							nb_cell_x = home_cell_x;
              if(home_cell_y == 0){
                nb_cell_y = CELL_COUNT_Y - 1;
              }
              else{
                nb_cell_y = home_cell_y - 1;
              }
							if (home_cell_z == CELL_COUNT_Z - 1) {
								nb_cell_z = 0;
							}
							else {
								nb_cell_z = home_cell_z + 1;
							}

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id] = nb_cell_id;

							// Get the # of particles in the current evaluated neighbor cell
							tmp_particle_num_1 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];

							// Process the 2nd cell (333)
							if (home_cell_x == CELL_COUNT_X-1) {
								nb_cell_x = 0;
							}
							else {
								nb_cell_x = home_cell_x + 1;
							}
							if (home_cell_y == CELL_COUNT_Y-1) {
								nb_cell_y = 0;
							}
							else {
								nb_cell_y = home_cell_y + 1;
							}
							if (home_cell_z == CELL_COUNT_Z-1) {
								nb_cell_z = 0;
							}
							else {
								nb_cell_z = home_cell_z + 1;
							}

							// Get the neighbor cell ID
							nb_cell_id = cell_index_calculator(nb_cell_x, nb_cell_y, nb_cell_z);
              neighbor_cell_id[filter_id + NUM_FILTER] = nb_cell_id;

							// Get the # of particles in both evaluated neighbor cells
							tmp_particle_num_2 = particle_in_cell_counter[nb_cell_z][nb_cell_y][nb_cell_x];

							filter_input_particle_num[0][filter_id] = (tmp_particle_num_1 > tmp_particle_num_2) ? tmp_particle_num_1 : tmp_particle_num_2;
							filter_input_particle_num[1][filter_id] = tmp_particle_num_1;
							filter_input_particle_num[2][filter_id] = tmp_particle_num_2;

							if (ENABLE_PRINT_DETAIL_MESSAGE) {
								cout << "*** Filter 6 assigned particles. ***" << endl;
								cout << tmp_particle_num_1 << " particles in the 1st cell (312)" << endl;
								cout << tmp_particle_num_2 << " particles in the 2nd cell (333)" << endl;
							}
							break;
#pragma endregion

						default: 
							cout << "*** No matching case for the filter: ***" << filter_id << endl;
							return 1;
						} // switch statement 
					} // Iterate through filters

					if (ENABLE_PRINT_DETAIL_MESSAGE) {
						cout << "*** Iteration: " << sim_iter << ", Home cell: " << home_cell_x << home_cell_y << home_cell_z << endl;
						cout << "Mapping cell particles to filters done ***\n" << endl;
					}

					/* Start Evaluation */
          // Only one iteration of force calculations are performed.
          // No motion update.

					// Home cell id
					int home_cell_id = cell_index_calculator(home_cell_x, home_cell_y, home_cell_z);

					// Home cell particle count
					int home_cell_particle_num = particle_in_cell_counter[home_cell_z][home_cell_y][home_cell_x];

					// Find the max # of particles in any of the neighbor cells.
					// This is the number of iterations for the outer loop
					filter_process_particle_max = *max_element(filter_input_particle_num[0], filter_input_particle_num[0] + NUM_FILTER);

					if (ENABLE_PRINT_DETAIL_MESSAGE) {
						cout << "*** Iteration: " << sim_iter << ", Home cell: " << home_cell_x << home_cell_y << home_cell_z << endl;
						cout << "Max neighbor partlces: " << filter_process_particle_max << endl;
					}
          

					// Force Calculation
					// Declare variables
					float ref_force_x_acc[14];
					float ref_force_y_acc[14];
					float ref_force_z_acc[14];
					// - Iterate for the max particle number in all neighbor cells (ref_particle_index)
					for (ref_particle_index = 0; ref_particle_index < filter_process_particle_max; ref_particle_index++){
            if(DEBUG){
              if(ref_particle_index == 1){
                return 0;
              }
            }
            // Initialize
            for(i = 0; i < 2*NUM_FILTER; i++){
					    ref_force_x_acc[i] = 0.0;
					    ref_force_y_acc[i] = 0.0;
					    ref_force_z_acc[i] = 0.0;
            }

					  // - For first 7 neighbors
					  for(filter_id = 0; filter_id < NUM_FILTER; filter_id++){
              ref_pos_x = cell_particle[0][neighbor_cell_id[filter_id]][ref_particle_index];
              ref_pos_y = cell_particle[1][neighbor_cell_id[filter_id]][ref_particle_index];
              ref_pos_z = cell_particle[2][neighbor_cell_id[filter_id]][ref_particle_index];

					    // - Iterate over all home cell particles
					    for(nb_particle_index = 0; nb_particle_index < home_cell_particle_num; nb_particle_index++){
                nb_pos_x = filter_input_particle_reservoir[0][0][nb_particle_index]; // 2nd index is always 0  
                nb_pos_y = filter_input_particle_reservoir[1][0][nb_particle_index]; // becase only filter 0 reservoir 
                nb_pos_z = filter_input_particle_reservoir[2][0][nb_particle_index]; // is populated with home cell particles

								// Calculate dx, dy, dz, r2
								dx = ref_pos_x - nb_pos_x;
								dy = ref_pos_y - nb_pos_y;
								dz = ref_pos_z - nb_pos_z;

								// Apply periodic boundary conditions
								dx -= BOUNDING_BOX_SIZE_X * round(dx / BOUNDING_BOX_SIZE_X);
								dy -= BOUNDING_BOX_SIZE_Y * round(dy / BOUNDING_BOX_SIZE_Y);
								dz -= BOUNDING_BOX_SIZE_Z * round(dz / BOUNDING_BOX_SIZE_Z);

								// Evaluate r2
								r2 = dx * dx + dy * dy + dz * dz;
								float inv_r2 = 1.0 / r2;

								// Pass the filter
								// Also check for particle_id > ref_id for home cell
								if (r2 >= EXCLUSION_2 && r2 < CUTOFF_RADIUS_2 && (filter_id > 0 | nb_particle_index > ref_particle_index)){
									tmp_counter_particles_within_cutoff += 1;
									float vdw_14, vdw_8, vdw_12, vdw_6;
									int lut_index;
									int tmp_nb_cell_id;
									int nb_particle_index_of_cell;
									if (ENABLE_INTERPOLATION) {
										seg_index = 0;
										while (r2 >= MIN_RANGE * pow(2, seg_index + 1)) {
											seg_index += 1;
										}
										if (seg_index >= SEGMENT_NUM) {
											cout << "seg_index: " << seg_index << endl;
											cout << "SEGMENT_NUM: " << SEGMENT_NUM << endl;
											cout << "*** Error: cannot locate the segment for input r2 ***" << endl;
											return 1;
										}

										// Locate the bin in the current segment
										float seg_min = MIN_RANGE * pow(2, seg_index);
										float seg_max = seg_min * 2;
										float seg_stride = (seg_max - seg_min) / BIN_NUM;
										int bin_index = (int)((r2 - seg_min) / seg_stride);

										// Calculate the index for table lookup
										lut_index = seg_index * BIN_NUM + bin_index;

										// Fetch the index for the polynomials
										float c0_vdw14 = c0_vdw_list_14[lut_index];
										float c1_vdw14 = c1_vdw_list_14[lut_index];
										float c0_vdw8 = c0_vdw_list_8[lut_index];
										float c1_vdw8 = c1_vdw_list_8[lut_index];
										float c2_vdw14 = 0;
										float c2_vdw8 = 0;
										float c3_vdw14 = 0;
										float c3_vdw8 = 0;
										if (INTERPOLATION_ORDER > 1) {
											c2_vdw14 = c2_vdw_list_14[lut_index];
											c2_vdw8 = c2_vdw_list_8[lut_index];
										}
										if (INTERPOLATION_ORDER > 2) {
											c3_vdw14 = c3_vdw_list_14[lut_index];
											c3_vdw8 = c3_vdw_list_8[lut_index];
										}

										// Declare the two terms of L-J force / r
										switch (INTERPOLATION_ORDER) {
										case 1:
											vdw_14 = c1_vdw14 * r2 + c0_vdw14;
											vdw_8 = c1_vdw8 * r2 + c0_vdw8;
											break;
										case 2:
											vdw_14 = c2_vdw14 * r2 * r2 + c1_vdw14 * r2 + c0_vdw14;
											vdw_8 = c2_vdw8 * r2 * r2 + c1_vdw8 * r2 + c0_vdw8;
											break;
										case 3:
											vdw_14 = c3_vdw14 * r2 * r2 * r2 + c2_vdw14 * r2 * r2 + c1_vdw14 * r2 + c0_vdw14;
											vdw_8 = c3_vdw8 * r2 * r2 * r2 + c2_vdw8 * r2 * r2 + c1_vdw8 * r2 + c0_vdw8;
											break;
										default:
											cout << "*** Error: No match for INTERPOLATION_ORDER ***" << endl;
											return 1;
										}
									}
									// Direct evaluation
									else {
										vdw_14 = OUTPUT_SCALE_INDEX * 48 * EPS * pow(SIGMA, 12) * pow(inv_r2, 7);
										vdw_8 = OUTPUT_SCALE_INDEX * 24 * EPS * pow(SIGMA, 6) * pow(inv_r2, 4);
									}

									// Calculate the total force, F_LJ is not the actual force, but force / r
									float F_LJ = (vdw_14 - vdw_8) * 1000;	// EPS should be kJ/particle instead of kJ/mol, so here multiply by 1000, from kN to N

									// Calculate the force components
									float F_LJ_x = F_LJ * dx;
									float F_LJ_y = F_LJ * dy;
									float F_LJ_z = F_LJ * dz;

									// Get force for neighbor particles
									float neg_F_LJ_x = -1 * F_LJ_x;
									float neg_F_LJ_y = -1 * F_LJ_y;
									float neg_F_LJ_z = -1 * F_LJ_z;

                  // Partial force write back values for home cell particles
									//if (DEBUG_PARTIAL_FORCE && filter_id == 0 && home_cell_z == 0 && home_cell_y == 0 && home_cell_x == 0) {
									if (DEBUG_PARTIAL_FORCE && home_cell_z == 0 && home_cell_y == 0 && home_cell_x == 0) {
										cout << "F_LJ_x: " << neg_F_LJ_x / MASS_Nav << endl;
										cout << "F_LJ_y: " << neg_F_LJ_y / MASS_Nav << endl;
										cout << "F_LJ_z: " << neg_F_LJ_z / MASS_Nav << endl;
										cout << "dx: " << dx << endl;
										cout << "dy: " << dy << endl;
										cout << "dz: " << dz << endl;
										cout << "r2: " << r2 << endl;
										cout << "filter: " << filter_id << endl;
										cout << "ref_index: " << ref_particle_index << endl;
										cout << "nb_index: " << nb_particle_index << endl;
										cout << endl;
									}

									// Accumulate force for reference particles
									// filter_id variable follows the neighbor number in the half shell scheme.
									ref_force_x_acc[filter_id] += F_LJ_x;
									ref_force_y_acc[filter_id] += F_LJ_y;
									ref_force_z_acc[filter_id] += F_LJ_z;
										
                } // if passed filter
              } //iterate nb_particle_index
					  } //filter_id 0-6

					  // - For second  7 neighbors
					  for(filter_id = NUM_FILTER; filter_id < 2*NUM_FILTER; filter_id++){
              ref_pos_x = cell_particle[0][neighbor_cell_id[filter_id]][ref_particle_index];
              ref_pos_y = cell_particle[1][neighbor_cell_id[filter_id]][ref_particle_index];
              ref_pos_z = cell_particle[2][neighbor_cell_id[filter_id]][ref_particle_index];

					    // - Iterate over all home cell particles
					    for(nb_particle_index = 0; nb_particle_index < home_cell_particle_num; nb_particle_index++){
                nb_pos_x = filter_input_particle_reservoir[0][0][nb_particle_index]; // 2nd index is always 0  
                nb_pos_y = filter_input_particle_reservoir[1][0][nb_particle_index]; // becase only filter 0 reservoir 
                nb_pos_z = filter_input_particle_reservoir[2][0][nb_particle_index]; // is populated with home cell particles

								// Calculate dx, dy, dz, r2
								dx = ref_pos_x - nb_pos_x;
								dy = ref_pos_y - nb_pos_y;
								dz = ref_pos_z - nb_pos_z;

								// Apply periodic boundary conditions
								dx -= BOUNDING_BOX_SIZE_X * round(dx / BOUNDING_BOX_SIZE_X);
								dy -= BOUNDING_BOX_SIZE_Y * round(dy / BOUNDING_BOX_SIZE_Y);
								dz -= BOUNDING_BOX_SIZE_Z * round(dz / BOUNDING_BOX_SIZE_Z);

								// Evaluate r2
								r2 = dx * dx + dy * dy + dz * dz;
								float inv_r2 = 1.0 / r2;

								// Pass the filter
								// Also check for particle_id > ref_id for home cell
								if (r2 >= EXCLUSION_2 && r2 < CUTOFF_RADIUS_2 && (filter_id > 0 | nb_particle_index > ref_particle_index)){
									tmp_counter_particles_within_cutoff += 1;
									float vdw_14, vdw_8, vdw_12, vdw_6;
									int lut_index;
									int tmp_nb_cell_id;
									int nb_particle_index_of_cell;
									if (ENABLE_INTERPOLATION) {
										seg_index = 0;
										while (r2 >= MIN_RANGE * pow(2, seg_index + 1)) {
											seg_index += 1;
										}
										if (seg_index >= SEGMENT_NUM) {
											cout << "seg_index: " << seg_index << endl;
											cout << "SEGMENT_NUM: " << SEGMENT_NUM << endl;
											cout << "*** Error: cannot locate the segment for input r2 ***" << endl;
											return 1;
										}

										// Locate the bin in the current segment
										float seg_min = MIN_RANGE * pow(2, seg_index);
										float seg_max = seg_min * 2;
										float seg_stride = (seg_max - seg_min) / BIN_NUM;
										int bin_index = (int)((r2 - seg_min) / seg_stride);

										// Calculate the index for table lookup
										lut_index = seg_index * BIN_NUM + bin_index;

										// Fetch the index for the polynomials
										float c0_vdw14 = c0_vdw_list_14[lut_index];
										float c1_vdw14 = c1_vdw_list_14[lut_index];
										float c0_vdw8 = c0_vdw_list_8[lut_index];
										float c1_vdw8 = c1_vdw_list_8[lut_index];
										float c2_vdw14 = 0;
										float c2_vdw8 = 0;
										float c3_vdw14 = 0;
										float c3_vdw8 = 0;
										if (INTERPOLATION_ORDER > 1) {
											c2_vdw14 = c2_vdw_list_14[lut_index];
											c2_vdw8 = c2_vdw_list_8[lut_index];
										}
										if (INTERPOLATION_ORDER > 2) {
											c3_vdw14 = c3_vdw_list_14[lut_index];
											c3_vdw8 = c3_vdw_list_8[lut_index];
										}

										// Declare the two terms of L-J force / r
										switch (INTERPOLATION_ORDER) {
										case 1:
											vdw_14 = c1_vdw14 * r2 + c0_vdw14;
											vdw_8 = c1_vdw8 * r2 + c0_vdw8;
											break;
										case 2:
											vdw_14 = c2_vdw14 * r2 * r2 + c1_vdw14 * r2 + c0_vdw14;
											vdw_8 = c2_vdw8 * r2 * r2 + c1_vdw8 * r2 + c0_vdw8;
											break;
										case 3:
											vdw_14 = c3_vdw14 * r2 * r2 * r2 + c2_vdw14 * r2 * r2 + c1_vdw14 * r2 + c0_vdw14;
											vdw_8 = c3_vdw8 * r2 * r2 * r2 + c2_vdw8 * r2 * r2 + c1_vdw8 * r2 + c0_vdw8;
											break;
										default:
											cout << "*** Error: No match for INTERPOLATION_ORDER ***" << endl;
											return 1;
										}
									}
									// Direct evaluation
									else {
										vdw_14 = OUTPUT_SCALE_INDEX * 48 * EPS * pow(SIGMA, 12) * pow(inv_r2, 7);
										vdw_8 = OUTPUT_SCALE_INDEX * 24 * EPS * pow(SIGMA, 6) * pow(inv_r2, 4);
									}

									// Calculate the total force, F_LJ is not the actual force, but force / r
									float F_LJ = (vdw_14 - vdw_8) * 1000;	// EPS should be kJ/particle instead of kJ/mol, so here multiply by 1000, from kN to N

									// Calculate the force components
									float F_LJ_x = F_LJ * dx;
									float F_LJ_y = F_LJ * dy;
									float F_LJ_z = F_LJ * dz;

									// Get force for neighbor particles
									float neg_F_LJ_x = -1 * F_LJ_x;
									float neg_F_LJ_y = -1 * F_LJ_y;
									float neg_F_LJ_z = -1 * F_LJ_z;

                  // Partial force write back values for home cell particles
									//if (DEBUG_PARTIAL_FORCE && filter_id == 0 && home_cell_z == 0 && home_cell_y == 0 && home_cell_x == 0) {
									if (DEBUG_PARTIAL_FORCE && home_cell_z == 0 && home_cell_y == 0 && home_cell_x == 0) {
										cout << "F_LJ_x: " << neg_F_LJ_x / MASS_Nav << endl;
										cout << "F_LJ_y: " << neg_F_LJ_y / MASS_Nav << endl;
										cout << "F_LJ_z: " << neg_F_LJ_z / MASS_Nav << endl;
										cout << "dx: " << dx << endl;
										cout << "dy: " << dy << endl;
										cout << "dz: " << dz << endl;
										cout << "r2: " << r2 << endl;
										cout << "filter: " << filter_id << endl;
										cout << "ref_index: " << ref_particle_index << endl;
										cout << "nb_index: " << nb_particle_index << endl;
										cout << endl;
									}

									// Accumulate force for reference particles
									// filter_id variable follows the neighbor number in the half shell scheme.
									ref_force_x_acc[filter_id] += F_LJ_x;
									ref_force_y_acc[filter_id] += F_LJ_y;
									ref_force_z_acc[filter_id] += F_LJ_z;
										
                } // if passed filter
              } //iterate nb_particle_index
					  } // filter_id 7-13

            // Print accumulated forces for the ref particles
            // This is equivelant to the force writebacks 
            if(DEBUG_PARTIAL_FORCE && ref_particle_index == 0 && home_cell_z == 0 && home_cell_y == 0 && home_cell_x == 0) {
              cout << endl;
              cout << "Accumulated forces for reference particles" << endl;
              for(int ct = 0; ct < 2*NUM_FILTER; ct++){
                cout << "neighbor: " << ct << endl;
                cout << "F_LJ_x: " << ref_force_x_acc[ct] / MASS_Nav << endl;
                cout << "F_LJ_y: " << ref_force_y_acc[ct] / MASS_Nav << endl;
                cout << "F_LJ_z: " << ref_force_z_acc[ct] / MASS_Nav << endl;
                cout << endl;
              }
              cout << "Ref ID " << ref_particle_index << "done." << endl;
              cout << endl;
            }
					} // Iterate ref_particle_index
					


					// Print out which home cell is done processing
					if (ENABLE_PRINT_DETAIL_MESSAGE) {
						cout << "*** Home cell " << home_cell_x << home_cell_y << home_cell_z << " force evaluation done! ***" << endl;
					}

				} // home cell z loop
			} // home cell y loop
    } // home cell x loop
	} // sim iteration

#pragma endregion

	output_file.close();
	return 0;
} //main




string get_input_path(string file_name) {
	// Not available for pdb files for now
	string path = COMMON_PATH + file_name;
	return path;
}

string get_energy_output_path() {
	string underscore = "_";
	string part_1 = "Output_Energy_FullScale_Sim_";
	string part_2 = to_string(TOTAL_PARTICLE);
	string part_3 = to_string(SIMULATION_TIMESTEP);
	string path = part_1 + DATASET_NAME + underscore + part_2 + underscore + part_3 + ".txt";
	return path;
}

void read_initial_input(string path, float** data_pos) {
	// Initial velocity is zero for all particles
	int i;
	ifstream raw(path.c_str());
	if (!raw) {
		cout << "*** Error reading input file! ***" << endl;
		exit(1);
	}
	string line;
	stringstream ss;
	for (i = 0; i < TOTAL_PARTICLE; i++) {
		getline(raw, line);
		ss.str(line);
    /******/
		ss >> data_pos[0][i] >> data_pos[1][i] >> data_pos[2][i];
		//ss >> data_pos[1][i] >> data_pos[2][i] >> data_pos[3][i];
    /******/
		ss.clear();
	}
}

void shift_to_first_quadrant(float** raw_data, float** shifted_data) {
	int i;
	/*
	float* max_x;
	float* max_y;
	float* max_z;
	*/
	float* min_x;
	float* min_y;
	float* min_z;
	/*
	max_x = max_element(raw_data[0], raw_data[0] + TOTAL_PARTICLE - 1);
	max_y = max_element(raw_data[1], raw_data[1] + TOTAL_PARTICLE - 1);
	max_z = max_element(raw_data[2], raw_data[2] + TOTAL_PARTICLE - 1);
	*/
	min_x = min_element(raw_data[0], raw_data[0] + TOTAL_PARTICLE);
	min_y = min_element(raw_data[1], raw_data[1] + TOTAL_PARTICLE);
	min_z = min_element(raw_data[2], raw_data[2] + TOTAL_PARTICLE);
	for (i = 0; i < TOTAL_PARTICLE; i++) {
		shifted_data[0][i] = raw_data[0][i] - *min_x;
		shifted_data[1][i] = raw_data[1][i] - *min_y;
		shifted_data[2][i] = raw_data[2][i] - *min_z;
	}
}

void map_to_cells(float** pos_data, float*** cell_particle, int*** particle_in_cell_counter) {
	int i;
	int cell_x, cell_y, cell_z;
	int out_range_particle_counter = 0;
	int counter = 0;
	int total_counter = 0;
	int cell_id;
	for (i = 0; i < TOTAL_PARTICLE; i++) {
		cell_x = pos_data[0][i] / CUTOFF_RADIUS;
		cell_y = pos_data[1][i] / CUTOFF_RADIUS;
		cell_z = pos_data[2][i] / CUTOFF_RADIUS;

		// Write the particle information to cell list
		if (cell_x >= 0 && cell_x < CELL_COUNT_X &&
			cell_y >= 0 && cell_y < CELL_COUNT_Y &&
			cell_z >= 0 && cell_z < CELL_COUNT_Z) {
			counter = particle_in_cell_counter[cell_z][cell_y][cell_x];
      /***************/
      //cout << "Mapping to cells cell_x:" << cell_x << " cell_y:" << cell_y << " cell_z:" << cell_z << " counter:" << counter << endl;
      /***************/
			if (DEBUG || DEBUG_MU) {
				if (counter >= DEBUG_PARTICLE_NUM) {
					continue;
				}
			}
			//cout << "(" << cell_x << ", " << cell_y << ", " << cell_z << ")" << endl;
			// Start from 0
			cell_id = cell_index_calculator(cell_x, cell_y, cell_z);
			cell_particle[0][cell_id][counter] = pos_data[0][i];
			cell_particle[1][cell_id][counter] = pos_data[1][i];
			cell_particle[2][cell_id][counter] = pos_data[2][i];
			particle_in_cell_counter[cell_z][cell_y][cell_x] += 1;
			total_counter += 1;
		}
		else {
			out_range_particle_counter += 1;
			//cout << "Out of range particle is: (" << pos_data[0][i] << ", " << pos_data[1][i] << ", " 
			//	 << pos_data[2][i] << ") " << endl;
		}
	}
	cout << "*** Particles mapping to cells finished! ***\n" << endl;
	cout << "Total of (" << total_counter << ") particles recorded" << endl;
	cout << "Total of (" << out_range_particle_counter << ") particles falling out of the range" << endl;
	//if (DEBUG) {
	//cout << "Positions (1, 2, 3): " << endl;
	//	for (i = 0; i < particle_in_cell_counter[0][1][2]; i++) {
	//		cout << "x: " << cell_particle[0][cell_index_calculator(0, 1, 2)][i]
	//			<< ", y: " << cell_particle[1][cell_index_calculator(0, 1, 2)][i]
	//			<< ", z: " << cell_particle[2][cell_index_calculator(0, 1, 2)][i] << endl;
	//	}
	//}
}

void set_to_zeros_3d(float*** matrix, int x, int y, int z) {
	int i, j, k;
	for (i = 0; i < z; i++) {
		for (j = 0; j < y; j++) {
			for (k = 0; k < x; k++) {
				matrix[i][j][k] = 0;
			}
		}
	}
}

void print_int_3d(int*** matrix, int x, int y, int z) {
	int i, j, k;
	for (i = 0; i < z; i++) {
		for (j = 0; j < y; j++) {
			for (k = 0; k < x; k++) {
			  cout << i << "," << j << "," << k << ": ";
        cout << "(" << (i*16 + j*4 + k) << ")";
			  cout << matrix[i][j][k] << endl;
			}
		}
	}
}

void set_to_zeros_3d_int(int*** matrix, int x, int y, int z) {
	int i, j, k;
	for (i = 0; i < z; i++) {
		for (j = 0; j < y; j++) {
			for (k = 0; k < x; k++) {
				matrix[i][j][k] = 0;
			}
		}
	}
}

void read_interpolation(string path, float* table) {
	int i;
	ifstream raw(path.c_str());
	if (!raw) {
		cout << "*** Error reading input file! ***" << endl;
		exit(1);
	}
	string line;
	stringstream ss;
	for (i = 0; i < INTERPOLATION_TABLE_SIZE; i++) {
		getline(raw, line);
		ss.str(line);
		ss >> table[i];
		ss.clear();
	}
}

int cell_index_calculator(int cell_x, int cell_y, int cell_z) {
	int index;
	index = cell_z * CELL_COUNT_Y * CELL_COUNT_X + cell_y * CELL_COUNT_X + cell_x;
	return index;
}

void update_int(int*** target, int*** tmp, int x, int y, int z) {
	int i, j, k;
	for (i = 0; i < z; i++) {
		for (j = 0; j < y; j++) {
			for (k = 0; k < x; k++) {
				target[i][j][k] = tmp[i][j][k];
			}
		}
	}
}

void update(float*** target, float*** tmp, int x, int y, int z) {
	int i, j, k;
	for (i = 0; i < z; i++) {
		for (j = 0; j < y; j++) {
			for (k = 0; k < x; k++) {
				target[i][j][k] = tmp[i][j][k];
			}
		}
	}
}
