#!/bin/bash


echo "cleaning up..."

cd data
	rm *.graphe *.plt *.gp *.eps *.out *.dat
cd ..

cd distances
	rm *.txt
cd ..

cd figs
	rm *.jpg

cd histograms
	rm *.eps *.pdf *.txt
cd ..

cd logs
	rm *.log
cd ..


cd src_data
	rm *.plt *.log
cd ..

rm *.pdf
