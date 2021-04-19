#!/bin/bash

no=2
CDMAIN=$PWD
CLEANLOC="/media/My_Book/PROJECTS/MESC/CHeq/SUBSTRATE/GraSPI/Variation/Periodic/clean"
TARGET="/media/My_Book/PROJECTS/MESC/CHeq/SUBSTRATE/GraSPI/Variation/Periodic"

for i in pn$no-*; do
	ff=`echo $i | sed "s/pn$no-//"`
	echo "$ff"
	echo $i
	mkdir $TARGET/pn$no/pn$no-$ff
	cp -r $CLEANLOC/* $TARGET/pn$no/pn$no-$ff/

	COPYLOC=$TARGET/pn$no/pn$no-$ff/src_data
	cp $CDMAIN/pn$no-$ff/dataCH* $COPYLOC
	cd ..
done















