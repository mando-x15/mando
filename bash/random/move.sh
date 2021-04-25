#!/bin/bash
shopt -s extglob

CDMAIN=$PWD
TARGET="/"

echo ""
for n in pn*; do
echo $n
cd $n

	for i in pn*; do

		cd $i
		echo " $i"
		cd $TARGET/$n/$i/src_data

		echo "  moving files..."
		mv *.gz $CDMAIN/$n/$i
		echo "  done"

		cd ..
		cd ..

	done
cd ..

done
shopt -u extglob
