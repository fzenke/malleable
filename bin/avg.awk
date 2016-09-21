#! /usr/bin/awk -f 
# avg.awk
# This script computes the mean an standard deviation of file or STDIO for each columns.
# The standard deviation is computed using Bessel's correction.
# fzenke, 2016
{
	for (i=1;i<=NF;i++) {
		sum[i] += 1.0*$i
		sum2[i] += 1.0*$i*$i
	}
}
END {
	for (i=1;i<=NF;i++) {
		mean = sum[i]/NR
		var  = ( 1.*sum2[i]-sum[i]**2/NR ) / (NR-1)
		std = sqrt(var)
		printf "%f  %f\t",mean,std
	}
	printf "\n"
}
