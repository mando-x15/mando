#!/bin/bash
CDMAIN=$PWD
for f in *.png; do	
	FILENAME=$f
	echo $FILENAME
	convert -crop 570x570+260+120 $FILENAME c$FILENAME
done

 




