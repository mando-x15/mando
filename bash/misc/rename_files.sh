#!/bin/bash

# loop over directories
for j in ke*; do

    cd $j
    echo ' '$j

		rm -f crop_dataCH2_init.png
		rm -f dataCH2_init.plt

        # rename to organize
        for f in *_final.plt; do
           mv -f "$f" dataCH2_0.080.plt;
        done
        
        for f in *_final.png; do
           mv -f "$f" crop_dataCH2_0.080.png;
        done

    cd ..
done
