#!/bin/bash

CDMAIN=$PWD

NOFTESTS=8
for (( i = 1; i <= $NOFTESTS; i++ )); do
	if [ -d "t$i" ]; then
		cd t$i
			rm *.*
			echo "test$i cleaned"
		cd ..
	fi 
done


