#!/bin/bash
shopt -s extglob

CDMAIN=$PWD
cd 2D_ptDeux

for n in pn*; do
echo $n
cd $n

	for i in pn*; do

		cd $i
		echo " $i"


		echo "  compressing..."
		gzip --fast *.plt
		echo "  done"

		cd ..


	done
cd ..

done
shopt -u extglob
