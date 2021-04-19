#!/bin/bash

CDDIR=$PWD
CDTOOLS=$CDDIR/tools

echo "converting data..."
./convert_data.sh

echo "making figs..."	
./make_figs.sh
			
echo "making tex..."
./make_tex.sh

pdflatex all_morphologies.tex

echo "  done"	
		
			#delete unimportant data
			echo "  deleting files..."
				
				#histograms
				cd histograms
				rm !(AllEta.eps|AllEta.pdf)
				cd ..

				#figs
				cd figs
				rm *
				cd ..

				#distances
				cd distances
				rm *
				cd ..

				#data
				cd data
				rm *.plt
				rm *.graphe
				cd ..

			echo "  done"

			echo "  compressing src_data"
			gzip -rv src_data
			echo "  done"

		done



