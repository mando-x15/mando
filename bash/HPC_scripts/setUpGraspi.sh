#!/bin/bash

CDMAIN=$PWD


NofTests=( 13 )
for((i=0;i<($NofTests);i++)); do


#check if files exist and cp them in

	testname=$i
	echo $testname 

	if [ ! -e "$i/data" ] && [ ! -e "$i/src_data" ]; then
		cp -R src/data $i
		cp -R src/distances $i
		cp -R src/logs $i
		cp -R src/src_data $i
		cp -R src/tools $i
		cp src/clean_up.sh $i
		cp src/Run.sh $i
	fi

	rm -f $i/dataCH_final.plt
	rm -rf $i/AllEta.dat $i/OUT.log
	rm -rf $i/crop_dataCH*


	mv $i/*.plt $i/src_data/
	mv $i/energy.txt $i/src_data/
	mv $i/*.o* $i/src_data/
	mv $i/config.txt $i/src_data/
	mv $i/allp-* $i/src_data/

	


done
