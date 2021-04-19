#!/bin/bash


CDMAIN=$PWD
CLEANLOC="/media/Seagate/PROJECTS/CHeqSensitivity/graspi/clean"
TARGET="/media/Seagate/PROJECTS/CHeqSensitivity/graspi/N300"

echo ""
for n in N*; do
echo $n
cd $n
	#check if there is already a folder for test
	if [ ! -e $TARGET/$n ]; then
		mkdir $TARGET/$n

		echo "  copying files..."
		cp -r $CLEANLOC/* $TARGET/$n

		COPYLOC=$TARGET/$n/src_data
		cp $CDMAIN/$n/dataCH* $COPYLOC
		

		# remove init and bndrCreated
		if [ -e $COPYLOC/dataCH_bndrCreated.plt ]; then
			rm $COPYLOC/dataCH_bndrCreated.plt
		fi

		if [ -e $COPYLOC/dataCH_init.plt ]; then
			rm $COPYLOC/dataCH_init.plt
		fi

		echo "  done"

	fi

cd ..


done














