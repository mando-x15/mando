#!/bin/bash

echo ""

echo "creating folder for compressed files"

#check if there is already a folder
if [ ! -e data ]; then
	mkdir data
fi

for n in dataCH*; do

	echo $n

	# convert to binary
	preplot $n bin$n

	# compress original file
	gzip $n
	
	# move to data file
	mv $n.gz data
	
done


