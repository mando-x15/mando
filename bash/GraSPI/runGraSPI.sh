#!/bin/bash
 

cd tools

echo "finding time..."
./findTime.sh

echo "converting data..."
./convert_data.sh

echo "making figs..."	
./make_figs.sh
			
echo "making tex..."
./make_tex.sh

pdflatex all_morphologies.tex

mv all_morphologies.pdf ..

cd ..

gnuplot Eta_plot.gp

epstopdf Etaplot.eps
rm Etaplot.eps

echo "done"	

echo "cleaning up..."

cd data
	rm *.graphe *.plt *.gp *.eps
cd ..

cd distances
	rm *.txt
cd ..

cd histograms
	rm *.eps *.pdf *.txt
cd ..







		




