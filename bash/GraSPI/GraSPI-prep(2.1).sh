#!/bin/bash
shopt -s extglob

CDMAIN=$PWD
CLEANLOC="/home/spfeife/PROJECTS/MESC/CHeq/TESTS/Substrate/GraSPI/clean"
TARGET="/home/spfeife/PROJECTS/MESC/CHeq/TESTS/Substrate/GraSPI"

echo ""
for n in pn*; do
echo $n
cd $n
	#check if there is already a folder for test
	if [ ! -e $TARGET/$n ]; then
		mkdir $TARGET/$n
	fi

	#see if dataCH_final.plt file exists and if .o exists to see if test has completed
	for i in pn*; do
		cd $i
		echo " $i"

		#if '.o' file exists
		if [ -e *.o* ] && [ -e *_final.plt ]; then

			# continue if dir has not been created 
			if [ ! -e $TARGET/$n/$i ]; then
				echo "  copying files..."
				mkdir $TARGET/$n/$i
				cp -r $CLEANLOC/* $TARGET/$n/$i

				COPYLOC=$TARGET/$n/$i/src_data
				cp $CDMAIN/$n/$i/dataCH* $COPYLOC
				echo "  done"
				echo "  deleting files..."
				rm !(dataCH.0000.plt|dataCH.0001.plt|*.data|*.o*|*.sh|*.dat)
			fi
		else
			echo "  skipping..."
			
		fi
		echo "  done"
		cd ..
	done
echo ""
cd ..

done

shopt -u extglob











