#!/bin/bash

OUTPUT_DIRECTORY=data/$(hostname)_$(date +%F)
mkdir -p "$OUTPUT_DIRECTORY"
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_$(date +%R).csv

# Write CSV header
echo "size,type,time,freq_before_ghz,freq_after_ghz,threads,peak_memory_mb" > "$OUTPUT_FILE"

# Collect all sizes
sizes=()
sizes+=($(seq 1 1 10))
sizes+=($(seq 10 5 100))
sizes+=($(seq 100 50 1000))
sizes+=($(seq 1000 500 10000))
sizes+=($(seq 10000 5000 100000))
sizes+=($(seq 100000 50000 1000000))

# Create list of all runs (each size repeated 10 times)
all_runs=()
for size in "${sizes[@]}"; do
    for rep in $(seq 1 30); do
        all_runs+=("$size")
    done
done

# Shuffle all runs
shuffled_runs=($(printf '%s\n' "${all_runs[@]}" | sort -R))

# Warmup phase: run 5 times on size 10000 to stabilize performance
for i in {1..5}; do
    ./src/parallelQuicksort 10000 > /dev/null 2>&1
done

# Run all tests in completely random order
for size in "${shuffled_runs[@]}"; do
    for type in seq par built; do
        if [ "$type" = "par" ]; then
            for threads in $(seq 2 128); do
                output=$( { time ./src/parallelQuicksort "$size" "$type" "$threads"; } 2>&1 )
                time=$(echo "$output" | grep "Parallel" | sed 's/.*took: \([0-9.]*\) sec\./\1/')
                freq_before=$(echo "$output" | grep "Freq before:" | sed 's/.*: \([0-9]*\) Hz/\1/')
                freq_after=$(echo "$output" | grep "Freq after:" | sed 's/.*: \([0-9]*\) Hz/\1/')
                freq_before_ghz=$(echo "scale=2; $freq_before / 1000000000" | bc)
                freq_after_ghz=$(echo "scale=2; $freq_after / 1000000000" | bc)
                peak_memory=$(echo "$output" | grep "Peak memory:" | sed 's/.*: \([0-9.]*\) MB/\1/')
                # Simple outlier check
                if [[ -z "$time" || "$time" == "0" ]]; then
                    continue
                fi
                echo "$size,$type,$time,$freq_before,$freq_after,$threads,$peak_memory" >> "$OUTPUT_FILE"
            done
        else
            output=$( { time ./src/parallelQuicksort "$size" "$type"; } 2>&1 )
            case $type in
                seq)
                    time=$(echo "$output" | grep "Sequential" | sed 's/.*took: \([0-9.]*\) sec\./\1/')
                    ;;
                built)
                    time=$(echo "$output" | grep "Built-in" | sed 's/.*took: \([0-9.]*\) sec\./\1/')
                    ;;
            esac
            freq_before=$(echo "$output" | grep "Freq before:" | sed 's/.*: \([0-9]*\) Hz/\1/')
            freq_after=$(echo "$output" | grep "Freq after:" | sed 's/.*: \([0-9]*\) Hz/\1/')
            freq_before_ghz=$(echo "scale=2; $freq_before / 1000000000" | bc)
            freq_after_ghz=$(echo "scale=2; $freq_after / 1000000000" | bc)
            peak_memory=$(echo "$output" | grep "Peak memory:" | sed 's/.*: \([0-9.]*\) MB/\1/')
            threads=1
            # Simple outlier check
            if [[ -z "$time" || "$time" == "0" ]]; then
                continue
            fi
            echo "$size,$type,$time,$freq_before_ghz,$freq_after_ghz,$threads,$peak_memory" >> "$OUTPUT_FILE"
        fi
    done
done
