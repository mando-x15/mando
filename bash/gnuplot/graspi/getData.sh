#!/bin/bash

DIR=$PWD

# make data.dat 
if [ -e $DIR/data.dat ]; then  
	rm $DIR/data.dat
	touch $DIR/data.dat
else
	touch $DIR/data.dat
fi 

tests=( X* )
NofTests=${#tests[@]}

for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}
	echo $testname 

	cd $testname
	X=${testname#X.1_N}

	# Read AllEta.dat file, extract data
	cd data

	# find number of lines in AllEta.dat file
	length=`wc -l "AllEta.dat" | awk '{print $1}'`

	# generate temp.out to store X values
	if [ -e temp.out ]; then  
		rm temp.out
		touch temp.out
	else
		touch $DIR/data.dat
	fi 

	# generate array with X values
	for((n=0;n<($length);n++)); do
		A[$n]=$X
		printf "%s\n" ${A[$n]} >> temp.out
	done

	# merge two files into one, then print selected columns
	pr -m -t -s\  temp.out AllEta.dat | gawk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}' >> $DIR/data.dat
	
	# add space in data.dat files to conform with gnuplot plotting structure
	printf "%s\n" >> $DIR/data.dat

	# remove temp.out file
	rm temp.out

cd $DIR
done


