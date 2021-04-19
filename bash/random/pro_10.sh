#!/bin/bash
shopt -s extglob

CDMAIN=$PWD


echo ""
for n in pn10*; do

	echo $n
	cd $n

		for i in pn*; do

		x="${i:5}"
		if [ $x -gt 4 ];then

		loop=$PWD

		cd $i
		echo $i

			#check if logs is empty
			cd logs

			dir=$PWD

			if [ $(ls -1A | wc -l) -eq 0 ]; then
			cd ..

				#run graspi
				echo "  running graspi..."
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

				echo "  compressing src_data..."
				gzip -rv src_data
				echo "  done"
			
				cd ..
			fi

			cd $loop
		
		fi

		done
	cd ..
done

shopt -u extglob
