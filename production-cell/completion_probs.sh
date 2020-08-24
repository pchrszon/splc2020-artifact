#!/usr/bin/env bash

MODEL_PATH="$1"
MIN_WORKPIECES="$2"
STEP="$3"
MAX_WORKPIECES="$4"

MODEL_FILE_NAME=$(basename "$MODEL_PATH")
MODEL=${MODEL_FILE_NAME%.*}

mkdir -p build
mkdir -p logs

for i in $(seq "$MIN_WORKPIECES" "$STEP" "$MAX_WORKPIECES"); do
    rbsc "$MODEL_PATH" --const "MAX_FINISHED=${i}" -o "build/${MODEL}_${i}.prism"

    prism "build/${MODEL}_${i}.prism" completion_probs.props -s | tee "logs/${MODEL}_${i}.log"
done

DAT_FILE="${MODEL}.dat"

echo "# Pmin Pmax" > "$DAT_FILE"
for i in $(seq "$MIN_WORKPIECES" "$STEP" "$MAX_WORKPIECES"); do
    result=$(grep "Result: " "logs/${MODEL}_${i}.log" | cut -d' ' -f 2 | paste -s -d' ')
    echo "$i" "$result" >> "$DAT_FILE"
done
