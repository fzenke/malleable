#!/bin/sh
DIR=$(dirname $1)
BIN=$(basename -s .cpp $1)
echo "Auryn run of $BIN in dir=$DIR started at $(date)" 
make -C $DIR $BIN && ./$BIN
