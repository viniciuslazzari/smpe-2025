#!/bin/bash

OUTPUT_DIRECTORY=data/$(hostname)_$(date +%F)
mkdir -p "$OUTPUT_DIRECTORY"
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_$(date +%R).txt

touch "$OUTPUT_FILE"

# Function to run tests for a given sequence
run_tests() {
    for i in "$@"; do
        for rep in $(seq 1 10); do
            echo "Size: $i" >> "$OUTPUT_FILE"
            ./src/parallelQuicksort "$i" >> "$OUTPUT_FILE"
        done
    done
}

# 1 to 10 → 20 points (step ≈ 0.5, rounded to integer → step=1)
run_tests $(seq 1 1 10)

# 10 to 100 → 20 points (step = (100-10)/19 ≈ 4.7 → step=5)
run_tests $(seq 10 5 100)

# 100 to 1000 → 20 points (step = (1000-100)/19 ≈ 47.3 → step=50)
run_tests $(seq 100 50 1000)

# 1000 to 10000 → 20 points (step = (10000-1000)/19 ≈ 473 → step=500)
run_tests $(seq 1000 500 10000)

# 10000 to 100000 → 20 points (step = (100000-10000)/19 ≈ 4737 → step=5000)
run_tests $(seq 10000 5000 100000)

# 100000 to 1000000 → 20 points (step = (1000000-100000)/19 ≈ 47368 → step=50000)
run_tests $(seq 100000 50000 1000000)
