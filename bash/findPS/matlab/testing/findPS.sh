#!/bin/bash

CDMAIN=$PWD
#path to matlab file
MPATH=/home/spfeife/Bash/findPS/matlab/testing

#filename
NAM="energy.txt"
COL="4"

#folders to search
files=t*


# rm any previous files
if [ -e timeOfPS.txt ]; then
	rm timeOfPS.txt
fi


for i in $files; do

	testname=$i
	echo $testname 
	cd $testname

	matlab -nodesktop -nojvm -nosplash -r "addpath('$MPATH'); fcn_max('$NAM'); quit; exit;" >/dev/null 2>&1

	cd $CDMAIN

done

#reset terminal
stty sane


#collect data
echo ""
echo "collecting data..."
echo ""

for i in $files; do

	testname=$i
	
	t=$(awk '{print $1}' $testname/tmp.txt)
	e=$(awk '{print $2}' $testname/tmp.txt)

	echo "$testname $t $e" >> timeOfPS.txt
	
	rm -f $testname/tmp.txt

done

echo "done"
