#!/bin/bash

CDMAIN=$PWD

DT="5e-5"

NofTests=( 2 )

for((i=0;i<($NofTests);i++)); do

    testname=$i
    echo $testname 
    cd $testname

	cd src_data
	
	# rename energy file, if exists
	if [ -e "energy.txt" ] && [ -e "energy1.txt" ]; then  #has been restarted before
    	mv -f energy.txt energy2.txt
	fi

	if [ -e "energy.txt" ] && [ ! -e "energy1.txt" ]; then  #first restart
    	mv -f energy.txt energy1.txt
	fi
	
	rm -f dataCH_bndrCreated.plt dataCH_init.plt

	# find the last file number (assumes it is 2 digits)
	for f in *.plt; do
		filenum=${f//[dataCH.plt]/}
	done
	lastfile=${filenum:2}

	# find time
	time=`grep "TITLE =" dataCH.00$lastfile.plt | sed 's/TITLE ="t=//' | sed 's/["]//' `

	
	# prepare tmp file, change typeOFIC
	sed 's/typeOfIC = 2/typeOfIC = 0/g' "config.txt" > tmp.txt 

	# check for previous restart commands
	if grep -qe "restartFromT" tmp.txt; then

		sed -i '/restartFromT/d' tmp.txt
		sed -i '/dtRestartFrom =/d' tmp.txt
		sed -i '/restartWritingFromI =/d' tmp.txt
		sed -i '/inputFilenameGridField =/d' tmp.txt

	fi

	# change name
 	mv tmp.txt "config.txt"
	
	# add restart commands
	echo "restartFromT = $time" >> config.txt
	echo "dtRestartFrom = $DT" >> config.txt
	echo "restartWritingFromI = $lastfile" >> config.txt
	echo "inputFilenameGridField = dataCH.00$lastfile.plt" >> config.txt	

# Graspi
#	Ly=`grep "Ly =" config.txt | sed 's/Ly =//'`
#	echo $Ly
cd ..

cd $CDMAIN

done
