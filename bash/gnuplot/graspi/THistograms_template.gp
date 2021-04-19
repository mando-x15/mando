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
set xlabel "time"
set xtics nomirror rotate
set ylabel "fraction"
set xr[0:]
set yr[0:]
set style fill solid border -1
set boxwidth 1

set terminal postscript eps enhanced color "Helvetica" 40

set boxwidth 10
set key below
set terminal postscript eps enhanced color "Helvetica" 30

set out "BothTimeHistogramAndCurveUsefulInterfaceToRed.eps"
plot "HistogramTimesGreenToRedViaBlack.txt"    using 1:($2/TOTINTBLACKANDWHITE) with boxes ls 4 notitle,\
     "HistogramTimesGreenToRedViaBlack.txt"    using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 24 title 'hole paths'
      
set out "BothTimeHistogramAndCurveUsefulInterfaceToBlue.eps"
plot "HistogramTimesGreenToBlueViaWhite.txt"   using 1:($2/TOTINTBLACKANDWHITE) with boxes ls 3 notitle,\
     "HistogramTimesGreenToBlueViaWhite.txt"   using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 23 title 'electron paths'

set out "BothTimeHistogramsUsefulInterface.eps"
plot "HistogramTimesGreenToRedViaBlack.txt"    using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 14 title 'hole paths' ,\
	 "HistogramTimesGreenToBlueViaWhite.txt"   using 1:($2/TOTINTBLACKANDWHITE) smooth csplines with line ls 13 title 'electron paths'
     
set out "BothTimeHistogramAndCurveUsefulDomainsToRed.eps"
plot "HistogramTimesBlackToRed.txt"    using 1:($2/TOT) with boxes ls 4 notitle,\
     "HistogramTimesBlackToRed.txt"    using 1:($2/TOT) smooth csplines with line ls 24 title 'hole paths'
     
set out "BothTimeHistogramAndCurveUsefulDomainsToBlue.eps"
plot "HistogramTimesWhiteToBlue.txt"   using 1:($2/TOT) with boxes ls 3 notitle,\
     "HistogramTimesWhiteToBlue.txt"   using 1:($2/TOT) smooth csplines with line ls 23 title 'electron paths'


set out "BothTimeHistogramsUsefulDomains.eps"
plot "HistogramTimesBlackToRed.txt"    using 1:($2/TOT) smooth csplines with line ls 14 title 'hole paths',\
	 "HistogramTimesWhiteToBlue.txt"   using 1:($2/TOT) smooth csplines with line ls 13 title 'electron paths'



