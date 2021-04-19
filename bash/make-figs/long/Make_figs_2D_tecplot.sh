#!/bin/bash


CDMAIN=$PWD

tests=( "pn6-1")

NofTests=${#tests[@]}

for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}
	echo $testname 

	cd $testname
	cp $CDMAIN/contmapplt2D2jpg .
	echo "foldename:  $testname"
	
	for f in dataCH*.plt; do	
				FILENAME=$f
				echo $FILENAME
				if [ ! -e $FILENAME.jpg ]; then  
					./contmapplt2D2jpg $f
				fi 
	done
	rm contmapplt2D2jpg

	cd $CDMAIN

done 

for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}
	echo $testname 

	cd $testname
	echo "foldename:  $testname"
	
	for f in dataCH*.jpg; do	
				FILENAME=$f
				echo $FILENAME
				rm $FILENAME
	done

	cd $CDMAIN

done 


