#!/bin/bash


CDMAIN=$PWD

tests=( t* )
NofTests=${#tests[@]}

for (( i=1; i < $NofTests; i++ )); do
	
    tname=t$i
    echo "  "$tname
	cd $tname
	
	#./RUN.sh

	cd $CDMAIN

done 




