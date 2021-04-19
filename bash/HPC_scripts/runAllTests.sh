#!/bin/bash


NOFTESTS=8
for (( i = 1; i <= $NOFTESTS; i++ )); do
	cd t$i
		cp src/*.* .
		echo "test$i"
		qsub submitOneTest.sh
	cd ..
done

#gnuplot compare1D.gp
