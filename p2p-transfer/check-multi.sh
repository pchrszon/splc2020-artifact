#!/usr/bin/env bash

# Verify the peer-to-peer file transfer system consisting of two interacting networks
#
# Usage: check-multi.sh
#   (no parameters)

set -eu

RBSC=rbsc
PRISM=prism
PRISM_OPTS="-javamaxmem 2g -cuddmaxmem 4g"

BUILD_DIR=build

mkdir -p "$BUILD_DIR"


$RBSC --no-warn "main-multi.rbl" -o "$BUILD_DIR/out.prism"
$PRISM $PRISM_OPTS "$BUILD_DIR/out.prism" sanity.props
