#!/bin/bash


CDMAIN=$PWD

tests=( e4*)

NofTests=${#tests[@]}


for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}
	echo $testname 

	cd $testname

	if [ -e contmapplt2D2jpg_mu ] || [ -e contmapplt2D2jpg_phi ]; then
		rm cont*
	fi

	cp $CDMAIN/contmapplt2D2jpg_mu .
	cp $CDMAIN/contmapplt2D2jpg_phi .
	echo "foldename:  $testname"

	#rm *.jpg

	if [ ! -d mu.jpg ]; then
		mkdir mu.jpg
		mkdir phi.jpg
	fi

	for f in dataCH*; do	
				FILENAME=$f
				echo $FILENAME
				if [ ! -e $FILENAME.jpg ]; then  
					./contmapplt2D2jpg_mu $f
					./contmapplt2D2jpg_phi $f
				fi 
	echo $testname

	done

	rm cont*

	cd $CDMAIN

done 




