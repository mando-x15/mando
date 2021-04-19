#!/bin/bash


touch 
# the touch command creates an empty file - or changes the timestamp of a file

DIR=$PWD

# make allEnergy.dat 
if [ -e $DIR/allEnergy.dat ]; then  
	rm $DIR/allEnergy.dat
	touch $DIR/allEnergy.dat
else
	touch $DIR/allEnergy.dat
fi 


