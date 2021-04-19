#!/bin/bash


CDMAIN=$PWD
TARGET="/media/Seagate/0"

echo ""
for n in *; do
	echo $n
	cd $n
	cp -r $TARGET/* .

	mv SubstratePattern.dat src_data
	mv SubstratePatternTOP.dat src_data
	mv config.txt src_data

cd $CDMAIN

done

