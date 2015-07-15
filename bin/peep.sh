#!/bin/bash

# Copyright 2015 Friedemann Zenke
# 
# Returns the last 20s or 20000 spikes whichever is fullfilled first from
# a *.ras or any Auryn time series file. Does not return the last spike/line
# because this can cause problems with online monitoring where the last line
# might be incomplete.
# 
# Usage:
# peep.sh rasfile.ras
# 
# Example usage from within gnuplot (e.g. to plot spikes from ongoing sim)
# plot '< peep.sh foobar.ras' with dots lc -1
# 
# Optional parameters:
# peep.sh rsafile.ras <timeinterval_in_seconds> <maximum_nun_spikes>

if [ "$2" != "" ]; then
	INTERVAL=$2
else
	INTERVAL=20
fi

if [ "$3" != "" ]; then
	TAIL=$3
else
	TAIL=20000
fi

END=`tail -n 1 $1 | awk '{ print $1 }'`

tail -n $TAIL $1 | awk 'BEGIN { thr = '$END'-'$INTERVAL'} !/^[ \t]*#/&&NF{ if ( $1 > thr && NF == fields ) print; fields = NF }' 
