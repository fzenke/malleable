#!/bin/bash

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
