#! /usr/bin/awk -f 
# 
# Copyright 2015 Friedemann Zenke
# 
# Extracts ISI from Auryn ras file data. 
# Best use in conjunction with a histogramming script. Like the 
# one provided in the TIESAN package.
# 
# Usage: 
# isi.awk < spikes.ras

{
	curt = $1
	if (firingtime[$2]>0) {
		isi = curt-firingtime[$2]
		if (isi)
			printf "%f\n",isi
	}
	firingtime[$2] = curt
}
