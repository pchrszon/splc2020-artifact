#!/usr/bin/env bash

# Verify a peer-to-peer file transfer system consisting of only a single network.
#
# Usage: check-single.sh <TOPO> <SIZE> <FILES>
#   - TOPO: the topology of the network, either 'star' or 'ring'
#   - SIZE: the number of stations in the network (should be at least 2)
#   - FILES: the number of distinct files in the network (should be at most SIZE - 1)

set -eu

RBSC=rbsc
PRISM=prism
PRISM_OPTS="-javamaxmem 2g -cuddmaxmem 4g"

BUILD_DIR=build


TOPO=$1
SIZE=$2
FILES=$3


mkdir -p "$BUILD_DIR"


$RBSC --no-warn "main-${TOPO}.rbl" -c "SIZE=${SIZE}" -c "FILES=${FILES}" -o "$BUILD_DIR/out.prism"
$PRISM $PRISM_OPTS "$BUILD_DIR/out.prism" sanity.props
