#! /usr/bin/awk -f 
# 
# Copyright 2015 Friedemann Zenke
# 
# Extracts mean firing rates from Auryn ras file data. 
# Has a hardcoded limit of maximum units N and does 
# not count silent units.
# Best use in conjunction with a histogramming script. Like the 
# one provided in the TIESAN package.
# 
# Usage: 
# rate_hist.awk < spikes.ras

BEGIN {
	N = 20000
	start = -1e-10
}
	
{
	curt = $1
	if (start<0)
		start = curt
	count[$2] += 1.0
}
END {
	simtime = curt-start
	print "# " curt " " start
	for (i=1; i<=N; i++) {
		if (count[i]>0)
			print 1.*count[i]/simtime
	}
}
