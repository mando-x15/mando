#!/bin/bash
shopt -s extglob

CDMAIN=$PWD


echo ""
for n in pn*; do

	echo $n
	cd $n

		for i in pn*; do
		cd $i
		echo $i

			#run graspi
			./convert_data.sh
			./make_figs.sh
			./make_tex.sh
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
done

shopt -u extglob
