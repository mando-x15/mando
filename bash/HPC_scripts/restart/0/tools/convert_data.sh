#!/bin/bash

CDDIR="$(dirname "$PWD")"

SOURCE=$CDDIR/src_data
CONVERTEDDATA=$CDDIR/data

if [ ! -d "$CONVERTEDDATA" ]; then
	mkdir $CONVERTEDDATA
fi 

GRASPI=/work/02143/spfeife/GraSPI-1.3.1/
PHI2PHASE="$GRASPI/tools/phi2phase/phi2phase"
PLT2GRAPHE="$GRASPI/tools/plt2graphe/src/plt2graph"


PHI=0.5

cd $SOURCE



for i in *.plt; do
	filename=`basename $i`
	echo $filename >> $CDDIR/OUT.log
	$PHI2PHASE $filename phase$filename $PHI

### Usage: plt2graphe <in_filename.plt> <out_filename.graphe> <Hmax-orig-scale> <Scale> <ifPer(1-yes, 0-no)> <nx>
#<Hmax-orig-scale> == Lz (the max height of the domain)
#<Scale> == .33*100 = 33 nm
#<nx> = elemnts in x-dir
	$PLT2GRAPHE phase$filename phase$filename.graphe 0.3 100 1 1570
	mv phase$filename $CONVERTEDDATA
	mv phase$filename.graphe $CONVERTEDDATA
done

cd ..
