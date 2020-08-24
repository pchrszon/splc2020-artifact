#!/usr/bin/env bash

set -eu

RBSC=rbsc
PRISM=prism
PRISM_OPTS="-cuddmaxmem 4g"

mkdir -p build
mkdir -p logs

MODELS=( "main-1-3-local" "main-2-5-local" "main-2-5-global" "main-2-6-local" )

for m in "${MODELS[@]}"; do
    $RBSC "${m}.rbl" -o "build/${m}.prism"
    $PRISM $PRISM_OPTS "build/${m}.prism" quant.props | tee "logs/${m}.log"
done
