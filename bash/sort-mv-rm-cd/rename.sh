#!/bin/bash



CDMAIN=$PWD

#tests=( Ly* )
#NofTests=${#tests[@]}

NofTests=3
for((i=0;i<($NofTests);i++)); do

	testname=$i
	echo $testname 

mv "${testname}" "t${testname}"


done


