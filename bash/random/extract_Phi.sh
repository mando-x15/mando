#!/bin/bash

#this file permanently removes headers and the node data at the bottom of plt file
#be sure to have data backed up

CDMAIN=$PWD

cd t-local

rm dataCH_bndrCreated.plt
rm dataCH_init.plt
rm dataCH_final.plt

for i in $(ls -1v *.plt ) ;  do
echo $i >> datafiles.dat

	sed -i -e '1285,$ d' -e '1,3d' $i
	awk < $i '{ printf "%s ", $3 >> "data.plt"}'
done

cd $CDMAIN


