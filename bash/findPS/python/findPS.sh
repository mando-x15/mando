#!/bin/bash

CDMAIN=$PWD

#python location
py='/home/spfeife/Bash/findPS'

	# delete any previous files
	if [ -e timeOfPS-tot.txt ]; then
		rm timeOfPS-tot.txt
	fi


for i in t*; do

	testname=$i
	echo "  "$testname 
	cd $testname

	# delete any previous files
	if [ -e timeOfPS.txt ]; then
		rm timeOfPS.txt
	fi

#copy in ps.py, run
	cp $py/ps-tofile.py .
	python ps-tofile.py
	rm ps-tofile.py

cd $CDMAIN

done


#collect data
echo "collecting data..."

for i in t*; do

	testname=$i
	
	#open file, store name in first col 
	v=$(awk '{print $2}' $testname/timeOfPS.txt)

	echo "$testname $v" >> timeOfPS-tot.txt

done

echo "done"
