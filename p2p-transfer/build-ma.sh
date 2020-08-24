#!/usr/bin/env bash

# Instantiate peer-to-peer file transfer models with increasing size for benchmark purposes.
# The generated PRISM models utilize the multi-action extension.
#
# Usage: build.sh <MAX_SIZE> <MAX_FILES>
#   - MAX_SIZE: generate models with 1 station up to MAX_SIZE number of stations
#   - MAX_FILES: generate models with 1 file up to MAX_FILES number of files

set -eu

RBSC=rbsc
PRISM_MA=prism-ma
MODEL=main-star.rbl

PRISM_OPTS="-javamaxmem 2g -cuddmaxmem 6g"

BUILD_DIR=build/bench


MAX_SIZE=$1
MAX_FILES=$2


mkdir -p "$BUILD_DIR"

for s in $(seq 2 "$MAX_SIZE"); do
    for f in $(seq 1 $((MAX_FILES >= s ? s - 1 : MAX_FILES)) ); do
        prefix="$BUILD_DIR/${s}_${f}"

        if [[ -f "${prefix}.ma.prism" ]]; then
            echo "Skipping ${prefix}.ma.prism"
        else
            $RBSC -m "$MODEL" -c "SIZE=${s}" -c "FILES=${f}" -o "$BUILD_DIR/out.prism" --no-warn
            $PRISM_MA $PRISM_OPTS "$BUILD_DIR/out.prism" -reorder -exportreordered "${prefix}.ma.prism"
        fi
    done
done

rm "$BUILD_DIR/out.prism"
