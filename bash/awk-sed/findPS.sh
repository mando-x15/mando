#!/bin/bash

CDMAIN=$PWD
EXECPS=/home/

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

	#find max
	PS=`$EXECPS $NAM $COL`
	
	echo "$PS" > tmp.txt	
	cd $CDMAIN

done


#collect data
echo ""
echo "collecting data..."
echo ""

for i in $files; do

	testname=$i
	
	t=$(awk '{print $1}' $testname/tmp.txt)
	e=$(awk '{print $2}' $testname/tmp.txt)

	echo "$testname $t $e" >> timeOfPS.txt

done

echo "done"
