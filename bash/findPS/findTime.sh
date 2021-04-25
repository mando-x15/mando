#!/bin/bash

# this file takes the .o file from cystorm and determines actual time  at which the plt files are written

# loop over all files in folder 
for n in h*; do

echo $n
cd $n

	# delete any previous files
	if [ -e time.out ]; then
		rm time.out
	fi

	if [ -e temp.out ]; then
		rm temp.out
	fi

	if [ -e temp2.out ]; then
		rm temp2.out
	fi

	# Read .out file, locate 'time step written' and store the whole line in $line
	grep -i 'time step written' *.o*| while read line; do

	# output all lines to temp.out
	echo $line >> temp.out
	done

	# read temp.out and store column 11 in temp2.out
	awk '{ printf "%s \n", $11 >> "temp2.out"}' temp.out

	# read temp2.out and remove 't:' , then store in time.out
	sed 's/^..//' temp2.out >> time.out

	# remove temp files
	rm temp.out
	rm temp2.out

cd ..
done

