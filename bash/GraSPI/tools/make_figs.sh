#!/bin/bash

CDDIR="$(dirname "$PWD")"


DATA=$CDDIR/src_data
FIGS=$CDDIR/figs

if [ ! -d "$FIGS" ]; then
	mkdir $FIGS;
fi 


cp contmapplt2jpg $DATA
cd $DATA
./contmapplt2jpg
rm contmapplt2jpg
rm *.mcr
rm tecplot.phy
mv *.jpg $FIGS	
cd ..


