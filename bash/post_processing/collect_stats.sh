#!/bin/bash


# loop over directories
for k in ke*; do

 cd $k
 echo ' '$k

	rm -f summary.txt

	# loop over all files in folder 
	for j in  $( ls -d lp_* | sort -V ) ; do

		echo " "$j
		cd $j

		RAW=`awk 'c&&!--c; /Total/{c=1}' 1x.o*`
		TIME=`awk "BEGIN {printf \"%.2f\n\", $RAW/60}"`
	
		RAW=`awk '/KSP its per ts:/ { print $0; }' 1x.o* | cut -d" " -f12`
		KSP=`awk "BEGIN {printf \"%.2f\n\", $RAW}"`
	
		RAW=`awk '/SNES its per ts:/ { print $0; }' 1x.o* | cut -d" " -f11`
		SNES=`awk "BEGIN {printf \"%.2f\n\", $RAW}"`
	
		KSPper=`awk "BEGIN {printf \"%.2f\n\", $KSP/$SNES}"`
	
		echo "$j $TIME $SNES $KSPper" >> ../summary.txt
	
		cd ..

	done

cd ..

done


