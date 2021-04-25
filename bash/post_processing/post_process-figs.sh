#!/bin/bash

UTIL="/home"

# zip all data
for j in ke*; do

	cd $j
	echo $j
	
	rm -f dataCH2_init.plt
	rm -f dataCH2_final.plt
	
	# clean up
	rm -f *.png
	
	# make figs
	python $UTIL/make_figs2d_evap.py $PWD
	
	# rename
	for f in *.png; do
 		mv $f crop_$f;
	done
	
	cd ..
done



