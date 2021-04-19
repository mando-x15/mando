#!/bin/bash

echo ""

echo "creating folder for compressed files"
mkdir data

for n in *.plt; do

	echo $n

	# convert to binary
	preplot $n bin$n

	# compress original file
	gzip $n
	
	# move to data file
	mv $n.gz data
	
done


