#!/bin/bash

# Creates 'data' & 'figs' directories, the moves .plt files and figures.
# Compresses data directory.

for j in t*; do

	cd $j

	# check if there is already a folder
	if [ ! -e data ]; then
		mkdir data
	fi
	
	if [ ! -e figs ]; then
		mkdir figs
	fi

	# move .plt files
	for n in dataCH*; do
		echo $n
		mv $n data 2>/dev/null
	done
	
	# move figs
	for n in crop_*; do
		echo $n
		mv $n figs 2>/dev/null
	done

	# compress data
	if [ ! -e data.tar.gz ]; then
		tar -zcvf data.tar.gz data/ 
	fi
	
	# if compressed folder exists, remove data dir
	if [ -e data.tar.gz ]; then
		rm -rf data
	fi
	
	cd ..
done