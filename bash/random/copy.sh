#!/bin/bash

CDMAIN=$PWD

NofTests=( 16 )

for((i=0;i<($NofTests);i++)); do

	testname=$i
	echo $testname 
	cd $testname

cp -r data /media/Seagate/X.04/$i

cd $CDMAIN

done
