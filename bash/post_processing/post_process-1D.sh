#!/bin/bash

UTIL='/media/'

# zip all data
for j in ke*; do

	cd $j
	
	rm -f dataCH2_init.plt
	rm -f dataCH2_final.plt
	
	cp $UTIL/make_figs.sh .
	cp $UTIL/make_plots.sh .
	cp $UTIL/make_mov.sh .
	
	# make figs
	./make_figs.sh
	
	# plot h-profile
	./make_plots.sh
	
	# make mp4
	./make_mov.sh
	
	cd ..
done



