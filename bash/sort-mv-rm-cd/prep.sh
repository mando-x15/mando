#!/bin/bash

CDMAIN=$PWD

#python location
py='/home'


NofTests=( 16 )
for((i=0;i<($NofTests);i++)); do

#remove graspi folders
	testname=$i
	echo $testname 
	cd $testname
	if [ -e "data" ]; then
		mv data/AllEta.dat .
		mv src_data/* .
	fi

	rm -rf data distances logs src_data tools
	rm -rf clean_up*.sh cout.log InputData.log M_n.txt prep1.sh
	rm run.sh Run.sh TStowrite.data snes_it.txt ts_adpt.txt

#merge energy files (if necessary)
	energyFiles=( energy*.txt )
	NoF=${#energyFiles[@]}


	if [ $NoF == 2 ]; then

		rm -f out.txt merge2.py
		cp $py/merge2.py .

		python merge2.py

		rm energy*.txt
		mv out.txt energy.txt
		rm merge2.py

	fi

	if [ $NoF == 3 ]; then

		rm -f out.txt merge3.py
		cp $py/merge3.py .

		python merge3.py

		rm energy*.txt
		mv out.txt energy.txt
		rm merge3.py

	fi
cd $CDMAIN

done
