#!/bin/bash


CDMAIN=$PWD

tests=( mu*)

NofTests=${#tests[@]}


for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}
	echo $testname 

	cd $testname

	if [ -e contmapplt1D2jpg_mu ] || [ -e contmapplt1D2jpg_phi ]; then
		rm cont*
	fi

	cp $CDMAIN/contmapplt1D2jpg_mu .
#	cp $CDMAIN/contmapplt1D2jpg_phi .
	echo "foldename:  $testname"

	#rm *.jpg

	if [ ! -d phi.jpg ]; then
		mkdir mu.jpg
		mkdir phi.jpg
	fi

	for f in dataCH*; do	
				FILENAME=$f
				echo $FILENAME
				if [ ! -e $FILENAME.jpg ]; then  
					./contmapplt1D2jpg_mu $f
#					./contmapplt1D2jpg_phi $f
				fi 
	echo $testname

	done

	rm cont*

	cd $CDMAIN

done 




