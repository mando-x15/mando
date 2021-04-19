#!/bin/bash

CDMAIN=$PWD

NofTests=( 16 )

for((i=0;i<($NofTests);i++)); do

	testname=$i
	echo $testname 
	cd $testname

cd data
	rm -f *.txt *.log *.graphe *.plt *.out
cd ..

cd distances
	rm -f *.txt
cd ..

cd logs
	rm -f *.log
cd ..

cd $CDMAIN

done
