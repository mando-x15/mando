set style line 1 lt 1 lw 1 ps 1 pt 6 linecolor rgb "grey"
set style line 2 lt 1 lw 1 ps 1 pt 6 linecolor rgb "white"
set style line 3 lt 1 lw 1 ps 1 pt 6 linecolor rgb "blue"
set style line 4 lt 1 lw 1 ps 1 pt 6 linecolor rgb "red"
set style line 5 lt 1 lw 1 ps 1 pt 6 linecolor rgb "green"

set style line 13 lt 1 lw 5 ps 1 pt 6 linecolor rgb "blue"
set style line 14 lt 2 lw 5 ps 1 pt 6 linecolor rgb "red"

set style line 23 lt 1 lw 8 ps 1 pt 6 linecolor rgb "black"
set style line 24 lt 1 lw 8 ps 1 pt 6 linecolor rgb "black"


set size 1.0,1.15
set xlabel "distance"
set xtics nomirror rotate
set ylabel "fraction"
set xr[0:]
set yr[0:]
set style fill solid border -1
set boxwidth 1

set terminal postscript eps enhanced color "Helvetica" 40

set out "HistogramPolymerToInterface.eps"
plot "HistogramDistancesBlackToGreen.txt"    using 1:($2/TOTBLACK) with boxes ls 5 notitle

set boxwidth 10

set out "HistogramInterfaceToAnodeViaPolymer.eps"
plot "HistogramDistancesGreenToRedViaBlack.txt"    using 1:($2/TOTBLACKINT) with boxes ls 4 notitle 

set out "HistogramInterfaceToCathodeViaFullerene.eps"
plot "HistogramDistancesGreenToBlueViaWhite.txt"       using 1:($2/TOTWHITEINT) with boxes ls 3 notitle 


set out "HistogramPolymerToAnode.eps"
plot "HistogramDistancesBlackToRed.txt"    using 1:($2/TOTBLACK) with boxes ls 4 notitle 

set out "HistogramFullereneToCathode.eps"
plot "HistogramDistancesWhiteToBlue.txt"    using 1:($2/TOTWHITE) with boxes ls 3 notitle 


set key below
set terminal postscript eps enhanced color "Helvetica" 30

set out "BothHistogramAndCurveUsefulInterfaceToRed.eps"
plot "HistogramDistancesGreenToRedViaBlack.txt"    using 1:($2/TOTINTBLACKANDWHITE) with boxes ls 4 notitle,\
     "HistogramDistancesGreenToRedViaBlack.txt"    using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 24 title 'hole paths'
      
     
set out "BothHistogramAndCurveUsefulInterfaceToBlue.eps"
plot "HistogramDistancesGreenToBlueViaWhite.txt"   using 1:($2/TOTINTBLACKANDWHITE) with boxes ls 3 notitle,\
     "HistogramDistancesGreenToBlueViaWhite.txt"   using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 23 title 'electron paths'
     
set out "BothHistogramAndCurveUsefulDomainsToRed.eps"
plot "HistogramDistancesBlackToRed.txt"    using 1:($2/TOT) with boxes ls 4 notitle,\
     "HistogramDistancesBlackToRed.txt"    using 1:($2/TOT) smooth csplines with line ls 24 title 'hole paths'
     
set out "BothHistogramAndCurveUsefulDomainsToBlue.eps"
plot "HistogramDistancesWhiteToBlue.txt"   using 1:($2/TOT) with boxes ls 3 notitle,\
     "HistogramDistancesWhiteToBlue.txt"   using 1:($2/TOT) smooth csplines with line ls 23 title 'electron paths'


set out "BothHistogramsUsefulInterface.eps"
plot "HistogramDistancesGreenToRedViaBlack.txt"    using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 14 title 'hole paths' ,\
	 "HistogramDistancesGreenToBlueViaWhite.txt"   using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 13 title 'electron paths'

set out "BothHistogramsUsefulDomains.eps"
plot "HistogramDistancesBlackToRed.txt"    using 1:($2/TOT) smooth csplines with line ls 14 title 'hole paths',\
	 "HistogramDistancesWhiteToBlue.txt"   using 1:($2/TOT) smooth csplines with line ls 13 title 'electron paths'


set terminal postscript eps enhanced color "Helvetica" 40
set yr[0:1]

set boxwidth 1

set out "CumHistogramPolymerToInterface.eps"
plot "CumHistogramDistancesBlackToGreen.txt" using 1:($2/TOTBLACK) with boxes ls 5 notitle

set boxwidth 10

set out "CumHistogramInterfaceToAnodeViaPolymer.eps" 
plot "CumHistogramDistancesGreenToRedViaBlack.txt" using 1:($2/TOTBLACKINT) with boxes ls 4 notitle 

set out "CumHistogramInterfaceToCathodeViaFullerene.eps"
plot "CumHistogramDistancesGreenToBlueViaWhite.txt"    using 1:($2/TOTWHITEINT) with boxes ls 3 notitle 


set out "CumHistogramPolymerToAnode.eps" 
plot "CumHistogramDistancesBlackToRed.txt" using 1:($2/TOTBLACK) with boxes ls 4 notitle 

set out "CumHistogramFullereneToCathode.eps" 
plot "CumHistogramDistancesWhiteToBlue.txt" using 1:($2/TOTWHITE) with boxes ls 3 notitle 



