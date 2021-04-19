#!/bin/bash


CDMAIN=$PWD

tests=( N* )

NofTests=${#tests[@]}

for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}
	echo $testname 

	cd $testname
	cp $CDMAIN/contmapplt2D2jpg .
	echo "foldename:  $testname"

	rm *.jpg

	for f in dataCH*; do	
				FILENAME=$f
				echo $FILENAME
				if [ ! -e $FILENAME.jpg ]; then  
					./contmapplt2D2jpg $f
				fi 
				#rm *.jpg
	echo $testname

	done
	rm contmapplt2D2jpg 

	cd $CDMAIN

done 




