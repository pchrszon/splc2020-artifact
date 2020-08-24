#!/usr/bin/env bash

# Instantiate peer-to-peer file transfer models with increasing size for benchmark purposes.
#
# Usage: build.sh <MAX_SIZE> <MAX_FILES>
#   - MAX_SIZE: generate models with 1 station up to MAX_SIZE number of stations
#   - MAX_FILES: generate models with 1 file up to MAX_FILES number of files

set -eu

RBSC=rbsc
MODEL=main.rbl

BUILD_DIR=build/bench


MAX_SIZE=$1
MAX_FILES=$2


mkdir -p "$BUILD_DIR"

for s in $(seq 2 "$MAX_SIZE"); do
    for f in $(seq 1 $((MAX_FILES >= s ? s - 1 : MAX_FILES)) ); do
        prefix="$BUILD_DIR/${s}_${f}"

        if [[ -f "${prefix}.prism" ]]; then
            echo "Skipping ${prefix}.prism"
        else
            $RBSC "$MODEL" -c "SIZE=${s}" -c "FILES=${f}" -o "${prefix}.prism" --no-warn
        fi
    done
done
