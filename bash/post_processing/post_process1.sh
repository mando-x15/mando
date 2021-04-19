#!/bin/bash
# POST_PROCESS1: Performs post processing for ternary datasets.
#
#	This script:
#		- Makes figures for PLT files
# 		- Makes energy plots
#
# Note: Enter 'y' to make images

# Make sure paths are correct
CDHOME=$PWD
TOOLS=~/Dropbox/APOLLO/phafic/tools
FIGS=$TOOLS/make_figs
PLT=$TOOLS/gnuplot

# loop over directories
for j in ke*; do

    cd $j
    echo ' '$j

    # only make plots if no arguments are presented
    if [ $# -eq 0 ]; then
        sh $PLT/make_plots_ternary.sh "$PWD"
    fi

    # if 'y' then make images and plots
    if [ "$1" = "y" ]; then

        rm -f ./*png

        # make figs
        python $FIGS/make_figs2d_evap.py "$PWD" 'no border'

        # rename to organize
        for f in *.png; do
            mv "$f" crop_"$f";
        done

        # make plots
        sh $PLT/make_plots_ternary.sh "$PWD"
    fi

    cd $CDHOME
done
