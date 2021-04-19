#!/bin/bash

CDDIR="$(dirname "$PWD")"
cd $CDDIR

# loop over all files in folder 
cd src_data

	# delete any previous files, if they exist
	if [ -e time.out ]; then
		rm time.out
	fi

	if [ -e temp.out ]; then
		rm temp.out
	fi

	if [ -e temp2.out ]; then
		rm temp2.out
	fi

	# Read data file, extract title line
	grep -i 'TITLE ="' *.plt| while read line; do

	# output all lines to temp.out
	echo $line >> temp.out
	done

	# read temp.out and store column 2 in temp2.out
	awk '{ printf "%s \n", $2 >> "temp2.out"}' temp.out

	# read temp2.out and remove the first four letters and the " at the end of the stream
	sed -e 's/....\(.*\)./\1/' -e 's/\"//g' temp2.out >> time.out

	# remove temp files
	rm temp.out
	rm temp2.out
		
	# move time.out file
	mv time.out ../data/time.out

cd ..


