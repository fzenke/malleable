# malleable

Command line tools to analyze and visualize data generated with Auryn (www.fzenke.net/auryn).


## Some usage examples

Plot the last few secons of spikes from ras or bras files. Useful for online monitoring:
> pras.sh somefile.bras 

Extract seconds 10 to 20 from a ras file and output them to stdout. Subsequent querys for the same interval are cached.
> range.sh 10 20 somefile.ras

Outputs neuronal firing rates to stdout. Best use a histogrammer (I like the one from the tisean package [http://www.mpipks-dresden.mpg.de/~tisean/] to format 
this data to display it nicely in gnuplot). 
> rate_hist.awk < somespikes.ras

From within gnuplot you can then for instance read spikes from an interval 
> gnuplot> plot '< range.sh 50 60 somespikes.ras | rate_hist.awk | histogram' with boxes

or if you are using binary ras files which makes extracting ranges much faster to do the same:
> gnuplot> plot '< aube -i somespikes.bras --from 50 --to 60 | rate_hist.awk | histogram' with boxes

To get the interspike interval (ISI) distribution:
> gnuplot> plot '< aube -i somespikes.bras --from 50 --to 60 | isi.awk | histogram' with boxes

And finally to get the coefficient of variation of the ISI distribution:
> gnuplot> plot '< aube -i somespikes.bras --from 50 --to 60 | cvisi.awk | histogram' with boxes

Peak into a ras file during a simultion to see the current spiking activity use peep.sh
> gnuplot> plot '< peep.sh somespikes.ras' with dots

When using BinarySpikeMonitors you can do the same directly with the Auryn Binary extract tool:
> gnuplot> plot '< aube -i somespikes.ras --last 10' with dots
