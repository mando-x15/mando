#!/bin/bash


CDMAIN=$PWD

tests=( 6*)

NofTests=${#tests[@]}


for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}
	echo $testname 

	cd $testname

	if [ -e contmapplt_ThreeD2jpg ]; then
		rm cont*
	fi

	cp $CDMAIN/contmapplt_ThreeD2jpg .
	echo "foldename:  $testname"

	rm *.jpg

	for f in bin*; do	
				FILENAME=$f
				echo $FILENAME
				if [ ! -e $FILENAME.jpg ]; then  
					./contmapplt_ThreeD2jpg $f
				fi 
				#rm *.jpg
	echo $testname

	done
	rm contmapplt_ThreeD2jpg 

	cd $CDMAIN

done 




