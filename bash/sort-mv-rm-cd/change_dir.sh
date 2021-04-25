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

			#cd location within folder
			
			## do something

			echo "  done"
			cd ..
			cd ..
		done
		cd ..
done

echo ""

shopt -u extglob
