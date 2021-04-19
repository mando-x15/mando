#!/bin/bash

cd pn3
CDMAIN=$PWD
tests=( "pn3-9" "pn3-10" "pn3-11" "pn3-13" "pn3-14" "pn3-15" "pn3-16")

NofTests=${#tests[@]}

for((i=0;i<($NofTests);i++)); do
	testname=${tests[i]}

	echo $testname 
	cd $testname
	./convert_data.sh
	./make_figs.sh
	./make_tex.sh
	cd $CDMAIN

done 
cd ..






