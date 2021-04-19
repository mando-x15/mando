#!/bin/bash

rm -f timeStep.txt

# loop over all files in folder 
for n in *n; do

#echo $n
cd $n

	time=`grep "Time[[:space:]]Step" output | cut -d" " -f11`
	nodes="${n%?}"
	echo "$nodes $time" >> ../timeStep.txt
cd ..
done

