#!/bin/bash
# REMOVE_FILES: Cleans up directory using brace expansion
#
####################################

# loop over directories
for j in ke*; do

    cd $j
    echo ' '$j
	
	rm -rf dataCH2_0.{16,17,18,19,2,3,4,5}*
	rm -rf crop_dataCH2_0.{16,17,18,19,2,3,4,5}*

    cd ..
done
