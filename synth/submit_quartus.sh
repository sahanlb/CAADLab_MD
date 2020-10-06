#! /bin/bash -l
# The -l specifies that we are loading modules
#
## Walltime limit
#$ -l h_rt=48:00:00
#
## Give the job a name.
#$ -N q_125_virtual
#
## Redirect error output to standard output
#$ -j y
#
## Ask for desired number of threads
#$ -pe omp 16

# Want more flags? Look here:
# http://www.bu.edu/tech/support/research/system-usage/running-jobs/submitting-jobs/

export LM_LICENSE_FILE='1800@alteralm.bu.edu'

# Load the correct modules
module load quartus_pro/18.1

# Immediately form fused output/error file, besides the one with the default name.
exec >  ${SGE_O_WORKDIR}/${JOB_NAME}-${JOB_ID}.scc.out 2>&1

# Set OMP_NUM_THREADS. In this case, NSLOTS is the number of cores.
export OMP_NUM_THREADS=$NSLOTS

# Run the executable
./run.sh

exit

