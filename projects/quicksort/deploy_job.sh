#!/bin/bash

#OAR -p sirius
#OAR -t exotic
#OAR -l host=1,walltime=6:00:00
#OAR -O OAR_%jobid%.out
#OAR -E OAR_%jobid%.err

# display some information about attributed resources
hostname

# navigate to the project directory
cd /home/vbergonz/smpe-2025/projects/quicksort

# run the benchmarking script
./scripts/run_benchmarking.sh