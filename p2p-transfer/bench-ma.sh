#!/usr/bin/env bash

# Verify benchmark models generated by build-ma.sh script.
#
# For each model instance, a single warm-up run is followed by 3 benchmark runs
# (number of runs is configurable below). The log-files containing the build and
# analysis times are written to the logs directory.
#
# Usage: bench.sh <MAX_SIZE> <MAX_FILES>
#   - analyze all models with up to MAX_SIZE stations and MAX_FILES files

set -eu

PRISM_MA=prism-ma

PRISM_OPTS="-javamaxmem 2g -cuddmaxmem 4g"

BUILD_DIR=build/bench
LOG_DIR=logs


MAX_SIZE=$1
MAX_FILES=$2
RUNS=3


mkdir -p "${LOG_DIR}"


run()
{
    local model="$BUILD_DIR/${2}.prism"

    if [[ -f "$model" ]]; then
        for r in $(seq 0 "$RUNS"); do
            if (( r > 0 )); then
                local out="$LOG_DIR/${2}.${r}.log"
            else
                local out="/dev/null"
            fi

            $1 "$model" sanity.props | tee "$out"
        done
    fi
}

for s in $(seq 2 "$MAX_SIZE"); do
    for f in $(seq 1 "$MAX_FILES"); do
        run "${PRISM_MA} ${PRISM_OPTS}" "${s}_${f}.ma"
    done
done
