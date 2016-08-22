#!/bin/bash
# Script that 'make compiles' and then runs a given Auryn simulation binary
DIR=$(dirname $1)
BIN=$(basename -s .cpp $1)
ARGS="${@:2}"
echo "Auryn run of $BIN in dir=$DIR started at $(date)" 
echo "With args $ARGS"
make -C $DIR $BIN && ./$BIN $ARGS
