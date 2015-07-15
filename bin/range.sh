#!/bin/bash

if [ "$1" != "" ]; then
	START=$1
else
	START=0
fi

if [ "$2" != "" ]; then
	STOP=$2
else
	STOP=$START+100
fi

if [ "$3" != "" ]; then
	FILE=$3
	CACHEFILE=$FILE.rangecache
	CACHERANGEFILE=$FILE.range
	if [ $CACHEFILE -nt $FILE ]; then
		CSTART=`head -n 1 $CACHERANGEFILE`
		CSTOP=`tail -n 1 $CACHERANGEFILE`
		if [ $START == $CSTART ] && [ $STOP == $CSTOP ]; then
			cat $CACHEFILE
			exit
		fi
	fi
	awk 'BEGIN { start = '$START'; stop = '$STOP'; } { if ( $1 < start ) skip; if ( $1 > start && $1 < stop && NF == fields ) print; fields = NF ; if ( $1 > stop ) exit}' $FILE | tee $CACHEFILE \
		&& echo $START > $CACHERANGEFILE \
		&& echo $STOP >> $CACHERANGEFILE \
		&& exit
	rm -rf $CACHEFILE
else
	awk 'BEGIN { start = '$START'; stop = '$STOP'; } { if ( $1 < start ) skip; if ( $1 > start && $1 < stop && NF == fields ) print; fields = NF ; if ( $1 > stop ) exit}' 
fi


