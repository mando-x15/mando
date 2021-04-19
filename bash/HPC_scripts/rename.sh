#!/bin/bash



CDMAIN=$PWD

#tests=( t* )
#NofTests=${#tests[@]}

NofTests=9
for((i=0;i<($NofTests);i++)); do

	testname=$i
	echo $testname 

mv "${testname}" "t${testname}"


done


