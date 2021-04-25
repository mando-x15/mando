#!/bin/bash

CDMAIN=$PWD
#path to matlab file
MPATH=

#filename
NAM="energy.txt"
COL="3"

#folders to search
files=t*


# rm any previous files
if [ -e timeOfPS.txt ]; then
	rm timeOfPS.txt
fi


for i in $files; do

	filename=$i
	
	# make sure that the 'filename' is a directory, not a text file. matlab will get hung up...
	if [ -d "$filename" ]; then
	
  		echo $filename
  		cd $filename
  
  		#run matlab script
  		matlab -nodesktop -nojvm -nosplash -r "addpath('$MPATH'); findBdry('$NAM'); quit; exit;" >/dev/null 2>&1

		cd $CDMAIN
   
fi
done

#reset terminal
stty sane


#collect data
echo ""
echo "collecting data..."
echo ""

for i in $files; do

	filename=$i
	
	# make sure filename is directory
	if [ -d "$filename" ]; then
	
		t=$(awk '{print $1}' $filename/tmp.txt)
		e=$(awk '{print $2}' $filename/tmp.txt)
		
		# print to file - removing the 't' from the first column
		str=${filename#"t"}
		echo "$str $t $e" >> timeOfPS.txt
	
		rm -f $filename/tmp.txt
	
	fi
done

echo "done"




