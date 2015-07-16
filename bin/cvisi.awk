#! /usr/bin/awk -f 
# 
# Copyright 2015 Friedemann Zenke
# 
# Extracts CVISI from Auryn ras file data. 
# Currently has a hardcoded limit of N cells for array size.
# Best use in conjunction with a histogramming script. Like the 
# one provided in the TIESAN package.
# 
# Usage: 
# cvisi.awk < spikes.ras

BEGIN {
	N = 20000
}
	
{
	curt = $1
	if (firingtime[$2]>0) {
		isi = curt-firingtime[$2]
		nspikes[$2] += 1
		sum[$2] += isi
		sum2[$2] += isi**2
	}
	firingtime[$2] = curt
}
END {
	for (i=1; i<=N; i++) {
		if (nspikes[i]>1) {
			mean = sum[i]/nspikes[i]
		    var  = sum2[i]/(nspikes[i]-1)-mean**2
			print sqrt(var)/mean
		}

	}
}
