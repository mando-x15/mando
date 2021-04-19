set style line 1 lt 1 lw 4 ps 1 pt 6 linecolor rgb "red"
set style line 2 lt 1 lw 4 ps 1 pt 6 linecolor rgb "blue"
set style line 3 lt 1 lw 4 ps 1 pt 6 linecolor rgb "green"
set style line 4 lt 1 lw 1 ps 1 pt 6 linecolor rgb "grey"
set style line 5 lt 1 lw 4 ps 1 pt 6 linecolor rgb "black"


set size 1.0,1.15
set xlabel "data set number"
set xtics nomirror rotate
set ytics nomirror
set ylabel "distance"
#set xr[0:]
set logscale x
set style fill solid border -1
set boxwidth 1

set terminal postscript eps enhanced color "Helvetica" 30
set out "AllDistancesHistogramInterfaceTopViaBlack.eps"
plot "AllDistancesIntToTopViaBlack.dat"              using 1:2 with line ls 1 notitle ,\
     "AllDistancesIntToTopViaBlack.dat"              using 1:($2+$3) with line ls 4 notitle ,\
     "AllDistancesIntToTopViaBlack.dat"              using 1:($2-$3) with line ls 4 notitle

set out "AllDistancesHistogramInterfaceBottomViaWhite.eps"
plot "AllDistancesIntToBottomViaWhite.dat"           using 1:2 with line ls 2 notitle ,\
     "AllDistancesIntToBottomViaWhite.dat"           using 1:($2+$3) with line ls 4 notitle ,\
     "AllDistancesIntToBottomViaWhite.dat"           using 1:($2-$3) with line ls 4 notitle 

set out "AllDistancesHistogramBlackToInterface.eps"
plot "AllDistancesBlackToInterface.dat"              using 1:2 with line ls 3 notitle ,\
     "AllDistancesBlackToInterface.dat"              using 1:($2+$3) with line ls 4 notitle,\
     "AllDistancesBlackToInterface.dat"              using 1:($2-$3) with line ls 4 notitle 	



set style line 11 lt 1 lw 4 ps 1 pt 6 linecolor rgb "red"
set style line 12 lt 2 lw 4 ps 1 pt 6 linecolor rgb "blue"
set style line 13 lt 3 lw 4 ps 1 pt 6 linecolor rgb "green"
set style line 14 lt 4 lw 4 ps 1 pt 6 linecolor rgb "grey"
set style line 15 lt 5 lw 4 ps 1 pt 6 linecolor rgb "black"



set size 2.0,1.0

set y2label "distance ratio"
set y2tics nomirror 0, 0.2 
set out "AllRatioDistances.eps"
plot "AllDistancesIntToTopViaBlack.dat"              using 1:2 with line ls 11 axis x1y1 title 'd-hole',\
     "AllDistancesIntToBottomViaWhite.dat"           using 1:2 with line ls 12 axis x1y1 title 'd-electron',\
     "AllDistancesBlackToInterface.dat"              using 1:2 with line ls 13 axis x1y1 title 'd-exiton',\
     "AllRatioDistances.dat"                         using 1:2 with line ls 15 axis x1y2 title 'd-hole/d-electron' ,\
     0.71						      with line ls 14 axis x1y2 notitle

