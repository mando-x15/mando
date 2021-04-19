#!/bin/bash

H=1.0
L=1.0
MUH=1
MUE=1


GRASPI=/home/spfeife/PACKAGES/GraSPI-1.3.1
GRASPIEXEC=$GRASPI/src/graspi
CHOMP=$GRASPI/external_packages/chomp/chomp
AVG=$GRASPI/tools/statsTools/avg
VAR=$GRASPI/tools/statsTools/var
D2T=$GRASPI/tools/estimateTimeFromDistances/DistanceToTime
ESB=$GRASPI/tools/estimateStructureBalance/EstimateStructureBalance
GETLINEFFILE=$GRASPI/tools/bash-tools/getNlineFromFile
EAEL=$GRASPI/tools/estimateAbsEtaLower/EstimateAbsEtaLower

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
TEXFILE=all_morphologies.tex

echo "\documentclass{article}" > $TEXFILE
echo "\usepackage{pslatex}" >> $TEXFILE
echo "\usepackage{amssymb}" >> $TEXFILE
echo "\pagestyle{empty}" >> $TEXFILE
echo "\usepackage{graphicx}" >> $TEXFILE
echo "\usepackage{grffile}" >> $TEXFILE
echo "\usepackage{fullpage}" >> $TEXFILE
echo "\begin{document}" >> $TEXFILE


f=0;
for i in *.graphe; do
	f=$(($f + 1))
	FILENAME=`basename $i`
	FILENAMEPLT=`echo ${i%???????}` #remove last .graphe
	echo ""
	echo "analyzing file $FILENAME"
	echo "plt filename: $FILENAMEPLT"
	$EAEL $FILENAMEPLT $H $L > $LOGS/graspi-new.$FILENAME.log
	echo "EAEL done!"
	$GRASPIEXEC $i > $LOGS/graspi.$FILENAME.log
	echo "GraSPI done!"
	cat $LOGS/graspi.$FILENAME.log | sed 's/white/fullerene/' | sed 's/black/polymer/' | sed 's/red/anode/' | sed 's/blue/cathode/' | sed 's/green/interface/' >> $LOGS/graspi-new.$FILENAME.log

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

	echo "Histogram created!"

	# COLLECT STATS
	TOT=`grep "Number of vertices:" $LOGS/graspi-new.$FILENAME.log | sed 's/Number of vertices: //' `
	TOTBLACK=`grep "Number of polymer vertices:" $LOGS/graspi-new.$FILENAME.log | sed 's/Number of polymer vertices: //' `
	TOTWHITE=`grep "Number of fullerene vertices:" $LOGS/graspi-new.$FILENAME.log | sed 's/Number of fullerene vertices: //' `
	TOTBLACKINT=`grep "Number of polymer int vertices with cont conn to anode:" $LOGS/graspi-new.$FILENAME.log | sed 's/Number of polymer int vertices with cont conn to anode: //' `
	TOTWHITEINT=`grep "Number of fullerene int vertices with cont conn to cathode:" $LOGS/graspi-new.$FILENAME.log | sed 's/Number of fullerene int vertices with cont conn to cathode: //' `
	TOTINTCOMP=`grep "Number of edges with complementary paths:" $LOGS/graspi-new.$FILENAME.log | sed 's/Number of edges with complementary paths: //' `
	TOTINTBLACKANDWHITE=$(echo "$TOTINTCOMP*2" | bc)

	ETAABSUPP=`grep "Eta abs - fraction of black vertices: " $LOGS/graspi.$FILENAME.log | sed 's/Eta abs \- fraction of black vertices: //' `
	ETAABSLOW=`grep "Eta abs - absorption depth: "           $LOGS/graspi-new.$FILENAME.log | sed 's/Eta abs \- absorption depth: //' `
	ETAABSLOW=$ETAABSUPP
	ETAOUTUPP=`grep "Eta out - useful regions - w/o islands: " $LOGS/graspi.$FILENAME.log | sed 's/Eta out - useful regions \- w\/o islands: //' `
	ETAOUTUPPPOL=`grep "Fraction of black vertices conn to red: " $LOGS/graspi.$FILENAME.log | sed 's/Fraction of black vertices conn to red: //' `
	ETAOUTUPPFULL=`grep "Fraction of white vertices conn to blue: " $LOGS/graspi.$FILENAME.log | sed 's/Fraction of white vertices conn to blue: //' `

	ETAOUTPATH=`grep "Eta out - fraction of interfacial edges with continous path to red and blue: " $LOGS/graspi.$FILENAME.log | sed 's/Eta out - fraction of interfacial edges with continous path to red and blue: //' `
	INTAREA=`grep "Number of interfacial edges: " $LOGS/graspi.$FILENAME.log | sed 's/Number of interfacial edges: //' `

	echo "Stats collected!"


	MUH=1
	MUE=1
	$D2T $DISTANCES/${i}$DINTANODE $MUH $DISTANCES/${i}$TINTANODE
	$D2T $DISTANCES/${i}$DINTACATHODE $MUE $DISTANCES/${i}$TINTACATHODE
	$CONSTRHISTO $DISTANCES/${i}$TINTANODE 10
	mv Histogram.txt Histogram$TINTANODE
	$CONSTRHISTO $DISTANCES/${i}$TINTACATHODE 10
	mv Histogram.txt Histogram$TINTACATHODE
	COMPPATH=$($ESB Histogram$TINTANODE Histogram$TINTACATHODE)
	ETAOUTBALANCEINT=`echo $COMPPATH | sed 's/Eta out: balanced structure: //'`
	echo "mobilites: hole $MUH, electron $MUE" >> graspi.$FILENAME.log
	echo "Complementary paths from interface: $ETAOUTBALANCEINT" >> graspi.$FILENAME.log
	$D2T $DISTANCES/${i}$DPOLANODE    $MUH $DISTANCES/${i}$TPOLANODE
	$D2T $DISTANCES/${i}$DFULLCATHODE $MUE $DISTANCES/${i}$TFULLCATHODE
	$CONSTRHISTO $DISTANCES/${i}$TFULLCATHODE 10
	mv Histogram.txt Histogram$TFULLCATHODE
	$CONSTRHISTO $DISTANCES/${i}$TPOLANODE 10
	mv Histogram.txt Histogram$TPOLANODE
	COMPPATH=$($ESB Histogram$TPOLANODE Histogram$TFULLCATHODE)
	ETAOUTBALANCEINT=`echo $COMPPATH | sed 's/Eta out: balanced structure: //'`
	ETAOUTBALANCE11=$ETAOUTBALANCEINT
	echo "mobilites: hole $MUH, electron $MUE" >> graspi.$FILENAME.log
	echo "Complementary paths: $ETAOUTBALANCEINT" >> graspi.$FILENAME.log
	echo "TOT=$TOT" > THistogram.gp
	echo "TOTBLACK=$TOTBLACK" >> THistogram.gp
	echo "TOTWHITE=$TOTWHITE" >> THistogram.gp
	echo "TOTBLACKINT=$TOTBLACKINT" >> THistogram.gp
	echo "TOTWHITEINT=$TOTWHITEINT" >> THistogram.gp
	echo "TOTINTBLACKANDWHITE=$TOTINTBLACKANDWHITE" >> THistogram.gp
	cat $CDTOOLS/THistograms_template.gp >> THistogram.gp
	gnuplot THistogram.gp
	mv BothTimeHistogramAndCurveUsefulInterfaceToRed.eps  ${MUH}${MUE}BothTimeHistogramAndCurveUsefulInterfaceToRed.eps
    mv BothTimeHistogramAndCurveUsefulInterfaceToBlue.eps ${MUH}${MUE}BothTimeHistogramAndCurveUsefulInterfaceToBlue.eps
    mv BothTimeHistogramsUsefulInterface.eps              ${MUH}${MUE}BothTimeHistogramsUsefulInterface.eps
    mv BothTimeHistogramAndCurveUsefulDomainsToRed.eps    ${MUH}${MUE}BothTimeHistogramAndCurveUsefulDomainsToRed.eps
    mv BothTimeHistogramAndCurveUsefulDomainsToBlue.eps   ${MUH}${MUE}BothTimeHistogramAndCurveUsefulDomainsToBlue.eps
    mv BothTimeHistogramsUsefulDomains.eps                ${MUH}${MUE}BothTimeHistogramsUsefulDomains.eps     

    	echo "Balanced structure - estimated!"

	LD=1
	NOFLD=$($QUERYHISTOGRAM $DISTANCES/${i}$DPOLINT $LD)
	FOFLD=$( echo "scale=3; $NOFLD / $TOTBLACK;" | bc )
	ETADISSLOW=$FOFLD
	echo "Eta diss: Ld=$LD  0$FOFLD" >> graspi.$FILENAME.log
	
	LD=10
	NOFLD=$($QUERYHISTOGRAM $DISTANCES/${i}$DPOLINT $LD)
	FOFLD=$( echo "scale=3; $NOFLD / $TOTBLACK;" | bc )
	ETADISSUPP=$FOFLD
	echo "Eta diss: Ld=$LD 0$FOFLD" >> graspi.$FILENAME.log

	echo "Ld - estimated!"

	TIME=$f
	head -${f} ../data/time.out > tmp.file
	TIME=`tail -1 tmp.file`
	echo "checking: $TIME"
	rm tmp.file
#	echo "1:$TIME 2:$ETAABSUPP 3:$ETADISSUPP 4:$ETAOUTUPP 5:$ETAABSLOW 6:$ETADISSLOW 7:$ETAOUTPATH 8:$ETAOUTBALANCE11 9:$ETAOUTUPPPOL 10:$ETAOUTUPPFULL" 
	echo "$TIME $ETAABSUPP $ETADISSUPP $ETAOUTUPP $ETAABSLOW $ETADISSLOW $ETAOUTPATH $ETAOUTBALANCE11 $ETAOUTUPPPOL $ETAOUTUPPFULL" >> AllEta.dat


	echo "TOT=$TOT" > Histogram.gp
	echo "TOTBLACK=$TOTBLACK" >> Histogram.gp
	echo "TOTWHITE=$TOTWHITE" >> Histogram.gp
	echo "TOTBLACKINT=$TOTBLACKINT" >> Histogram.gp
	echo "TOTWHITEINT=$TOTWHITEINT" >> Histogram.gp
	echo "TOTINTBLACKANDWHITE=$TOTINTBLACKANDWHITE" >> Histogram.gp
	cat $CDTOOLS/Histograms_template.gp >> Histogram.gp

	gnuplot Histogram.gp

	# PREPARE TEX FILE
	echo "\section{Morphology: }" >> $TEXFILE	

	FILENAMED=`echo $FILENAMEPLT | sed 's/phase//'`
	echo "\parbox{0.8\textwidth}{" >> $TEXFILE
	echo "\begin{center}\includegraphics[width=0.4\textwidth]{$FIGS/crop$FILENAMED.jpg} \end{center}" >> $TEXFILE
	echo "}\newline" >> $TEXFILE

	echo "\parbox{0.69\textwidth}{\begin{small}" >> $TEXFILE
	cat $LOGS/graspi-new.$FILENAME.log | sed -e 's/$/\\\\/' >> $TEXFILE
	cat graspi.$FILENAME.log | sed -e 's/$/\\\\/' >> $TEXFILE
	echo "" >> $TEXFILE
	echo "\end{small}}\newline" >> $TEXFILE
	echo "\begin{center}" >> $TEXFILE
	echo "\parbox{0.33\textwidth}{\begin{scriptsize}Distance from Polymer Vertex to Interface\end{scriptsize}\newline" >> $TEXFILE
	echo "\includegraphics[width=0.3\textwidth]{$HISTO/${FILENAME}CumHistogramPolymerToInterface.pdf}} \newline" >> $TEXFILE

	echo "Distance from Interface to Electrodes \newline" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}BothHistogramAndCurveUsefulInterfaceToRed.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}BothHistogramAndCurveUsefulInterfaceToBlue.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}BothHistogramsUsefulInterface.pdf}\newline" >> $TEXFILE

	echo "Distance of useful paths to electrodes \newline" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}BothHistogramAndCurveUsefulDomainsToRed.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}BothHistogramAndCurveUsefulDomainsToBlue.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}BothHistogramsUsefulDomains.pdf}\newline" >> $TEXFILE

	MUH=1
	MUE=1
	echo "$MUH $MUE \newline" >> $TEXFILE
	echo "Distance from Interface to Electrodes \newline" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}${MUH}${MUE}BothTimeHistogramAndCurveUsefulInterfaceToRed.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}${MUH}${MUE}BothTimeHistogramAndCurveUsefulInterfaceToBlue.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}${MUH}${MUE}BothTimeHistogramsUsefulInterface.pdf}\newline" >> $TEXFILE

	echo "Distance of useful paths to electrodes \newline" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}${MUH}${MUE}BothTimeHistogramAndCurveUsefulDomainsToRed.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}${MUH}${MUE}BothTimeHistogramAndCurveUsefulDomainsToBlue.pdf}" >> $TEXFILE
	echo "\includegraphics[width=0.33\textwidth]{$HISTO/${FILENAME}${MUH}${MUE}BothTimeHistogramsUsefulDomains.pdf}\newline" >> $TEXFILE

	echo "\end{center}" >> $TEXFILE



	for j in *.txt; do
		mv $j $HISTO/${FILENAME}${j}
	done
	
	for j in *.eps; do 
		mv $j $HISTO/${FILENAME}$j
	done
		
	rm *.log

done


####		Summary of all morphologies		###########	

echo "\newpage" >> $TEXFILE
echo "\section{Summary of all Morphologies}" >> $TEXFILE	
echo "\includegraphics[width=0.99\textwidth]{$HISTO/AllEta}\newline" >> $TEXFILE

echo "\end{document}" >> $TEXFILE
mv $TEXFILE $CDTOOLS


cp $CDTOOLS/All_Eta.gp .
gnuplot All_Eta.gp
cp AllEta.eps $HISTO


cd ..




cd $HISTO
for i in *.eps; do
	epstopdf $i
done


cd $CDDIR


