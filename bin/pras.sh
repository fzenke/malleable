#!/bin/bash

# Copyright 2015 Friedemann Zenke
# Plots end of ras file from command line using gnuplot.
# Example usage:
# pras.sh outputfile.ras
# 
# Accepts a second file too e.g.:
# pras.sh excitatory.0.ras inhibitory.0.ras

NSPIKES=20000

if [ "$1" != "" ]; then
	FILE=$1
else
	FILE=`ls -tr1 *.ras | tail -n 1`
fi


if [ "$2" != "" ]; then
	if [ $2 = "png" ]; then
		BASE=`basename $FILE .ras`
cat << __EOF | gnuplot 
# set title '$BASE'
set out '$BASE.png'
unset key
set term png
set border 3
set xtics nomirror out
set ytics nomirror out
set xlabel 'Time [s]'
set ylabel 'Neuron ID'
plot '< peep.sh $FILE $NSPIKES' with dots lc -1
unset out
__EOF
	else
		FILE2=$2
cat << __EOF | gnuplot -p 
set xlabel 'Time [s]'
plot '< peep.sh $FILE $NSPIKES' with dots lc -1,\
	'< peep.sh $FILE2 $NSPIKES' using 1:(-column(2)) with dots lc 3 
__EOF
	fi
	else
cat << __EOF | gnuplot -p 
set xlabel 'Time [s]'
plot '< peep.sh $FILE $NSPIKES' with dots lc -1
__EOF
fi

