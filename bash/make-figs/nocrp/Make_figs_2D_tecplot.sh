#!/bin/bash


CDMAIN=$PWD




rm -f *.jpg

	for f in dataCH*; do	
				FILENAME=$f
				echo $FILENAME
				if [ ! -e $FILENAME.jpg ]; then  
					./contmapplt2D2jpg $f
				fi 

	done






