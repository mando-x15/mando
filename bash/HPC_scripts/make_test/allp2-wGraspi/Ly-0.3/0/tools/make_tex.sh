#!/bin/bash

# key
# /white/fullerene/' 
# /black/polymer/' 
# /red/anode/' 
# /blue/cathode/' 
# /green/interface/' 


H=1.0
L=1.0
MUH=1
MUE=1


GRASPI=/work/02143/spfeife/GraSPI-1.3.1
GRASPIEXEC=$GRASPI/src/graspi
CHOMP=$GRASPI/external_packages/chomp/chomp
AVG=$GRASPI/tools/statsTools/avg
VAR=$GRASPI/tools/statsTools/var
D2T=$GRASPI/tools/estimateTimeFromDistances/DistanceToTime
GETLINEFFILE=$GRASPI/tools/bash-tools/getNlineFromFile

CONSTRHISTO=$GRASPI/tools/constructHistogram/ConstructHistogram
QUERYHISTOGRAM=$GRASPI/tools/constructHistogram/QueryHistogram

CDDIR="$(dirname "$PWD")"
CDTOOLS=$CDDIR/tools

DATA=$CDDIR/data
LOGS=$CDDIR/logs
FIGS=$CDDIR/figs
HISTO=$CDDIR/histograms
DISTANCES=$CDDIR/distances

cd $DATA

f=0;
for i in *.graphe; do
	f=$(($f + 1))
	FILENAME=`basename $i`
	FILENAMEPLT=`echo ${i%???????}` #remove last .graphe
	echo "" > OUT.log
	echo "analyzing file $FILENAME" >> $CDDIR/OUT.log
	echo "plt filename: $FILENAMEPLT" >> $CDDIR/OUT.log
	$GRASPIEXEC $i > $LOGS/graspi.$FILENAME.log
	echo "GraSPI done!" >> $CDDIR/OUT.log

	for j in Distances*.txt; do
		mv $j $DISTANCES/${FILENAME}${j}
	done

	DINTANODE=DistancesGreenToRedViaBlack.txt
	DINTACATHODE=DistancesGreenToBlueViaWhite.txt
	DPOLANODE=DistancesBlackToRed.txt
	DFULLCATHODE=DistancesWhiteToBlue.txt
	DPOLINT=DistancesBlackToGreen.txt
	TINTANODE=TimesGreenToRedViaBlack.txt
	TINTACATHODE=TimesGreenToBlueViaWhite.txt
	TPOLANODE=TimesBlackToRed.txt
	TFULLCATHODE=TimesWhiteToBlue.txt
	TPOLINT=TimesBlackToGreen.txt
	
	$CONSTRHISTO $DISTANCES/${i}$DINTANODE 10
	mv Histogram.txt Histogram$DINTANODE
	mv CumHistogram.txt CumHistogram$DINTANODE
	$CONSTRHISTO $DISTANCES/${i}$DINTACATHODE 10
	mv Histogram.txt Histogram$DINTACATHODE
	mv CumHistogram.txt CumHistogram$DINTACATHODE

	$CONSTRHISTO $DISTANCES/${i}$DPOLANODE 10
	mv Histogram.txt Histogram$DPOLANODE
	mv CumHistogram.txt CumHistogram$DPOLANODE
	$CONSTRHISTO $DISTANCES/${i}$DFULLCATHODE 10
	mv Histogram.txt Histogram$DFULLCATHODE
	mv CumHistogram.txt CumHistogram$DFULLCATHODE

	$CONSTRHISTO $DISTANCES/${i}$DPOLINT 1
	mv Histogram.txt Histogram$DPOLINT
	mv CumHistogram.txt CumHistogram$DPOLINT

	echo "Histogram created!" >> $CDDIR/OUT.log


	# COLLECT STATS
	TOT=`grep "Number of vertices:" $LOGS/graspi.$FILENAME.log | sed 's/Number of vertices: //' `
	TOTBLACK=`grep "Number of black vertices:" $LOGS/graspi.$FILENAME.log | sed 's/Number of black vertices: //' `
	TOTWHITE=`grep "Number of white vertices:" $LOGS/graspi.$FILENAME.log | sed 's/Number of white vertices: //' `
	TOTBLACKINT=`grep "Number of black int vertices with cont conn to red:" $LOGS/graspi.$FILENAME.log | sed 's/Number of black int vertices with cont conn to red: //' `
	TOTWHITEINT=`grep "Number of white int vertices with cont conn to blue:" $LOGS/graspi.$FILENAME.log | sed 's/Number of white int vertices with cont conn to blue: //' `
	TOTINTCOMP=`grep "Number of edges with complementary paths:" $LOGS/graspi.$FILENAME.log | sed 's/Number of edges with complementary paths: //' `
	TOTINTBLACKANDWHITE=$(echo "$TOTINTCOMP*2" | bc)

	ETAOUTUPP=`grep "Eta out - useful regions - w/o islands: " $LOGS/graspi.$FILENAME.log | sed 's/Eta out - useful regions \- w\/o islands: //' `
	ETAOUTUPPPOL=`grep "Fraction of black vertices conn to red: " $LOGS/graspi.$FILENAME.log | sed 's/Fraction of black vertices conn to red: //' `
	ETAOUTUPPFULL=`grep "Fraction of white vertices conn to blue: " $LOGS/graspi.$FILENAME.log | sed 's/Fraction of white vertices conn to blue: //' `
	ETAOUTPATH=`grep "Eta out - fraction of interfacial edges with continous path to red and blue: " $LOGS/graspi.$FILENAME.log | sed 's/Eta out - fraction of interfacial edges with continous path to red and blue: //' `
	INTAREA=`grep "Number of interfacial edges: " $LOGS/graspi.$FILENAME.log | sed 's/Number of interfacial edges: //' `

	echo "Stats collected!" >> $CDDIR/OUT.log

	echo "" >> $LOGS/graspi.$FILENAME.log

	LD=1
	NOFLD=$($QUERYHISTOGRAM $DISTANCES/${i}$DPOLINT $LD)
	FOFLD=$( echo "scale=3; $NOFLD / $TOTBLACK;" | bc )
	ETADIS1=$FOFLD
	echo "Eta diss: Ld=$LD 0$ETADIS1" >> $LOGS/graspi.$FILENAME.log

	LD=5
	NOFLD=$($QUERYHISTOGRAM $DISTANCES/${i}$DPOLINT $LD)
	FOFLD=$( echo "scale=3; $NOFLD / $TOTBLACK;" | bc )
	ETADIS5=$FOFLD
	echo "Eta diss: Ld=$LD 0$ETADIS5" >> $LOGS/graspi.$FILENAME.log

	LD=10
	NOFLD=$($QUERYHISTOGRAM $DISTANCES/${i}$DPOLINT $LD)
	FOFLD=$( echo "scale=3; $NOFLD / $TOTBLACK;" | bc )
	ETADIS10=$FOFLD
	echo "Eta diss: Ld=$LD 0$ETADIS10" >> $LOGS/graspi.$FILENAME.log

	LD=15
	NOFLD=$($QUERYHISTOGRAM $DISTANCES/${i}$DPOLINT $LD)
	FOFLD=$( echo "scale=3; $NOFLD / $TOTBLACK;" | bc )
	ETADIS15=$FOFLD
	echo "Eta diss: Ld=$LD 0$ETADIS15" >> $LOGS/graspi.$FILENAME.log


	echo "Ld - estimated!" >> $CDDIR/OUT.log

	TIME=$f
	head -${f} ../data/time.out > tmp.file
	TIME=`tail -1 tmp.file`
	echo "checking: $TIME" >> $CDDIR/OUT.log
	rm tmp.file
	echo "$TIME $ETADIS1 $ETADIS5 $ETADIS10 $ETADIS15 $ETAOUTUPP $ETAOUTPATH $ETAOUTUPPPOL $ETAOUTUPPFULL $INTAREA" >> AllEta.dat

	echo "" >> $CDDIR/OUT.log

done



cd ..

cd $CDDIR

