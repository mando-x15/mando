#!/bin/bash

# Official colors from OpenOffice
set style line 1 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#7076F1"
set style line 2 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#D12124"
set style line 3 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#FBE249"
set style line 4 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#39AA00"
set style line 5 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#FF6600"

set style line 11 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#4C2D9B"
set style line 12 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#770003"
set style line 13 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#F29E25"
set style line 14 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#1E8500"
set style line 15 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#AA4400"

set style line 16 lc rgb '#000000' lt 1 lw 3 pt 3 pi -1 ps 0.55 #black
set style line 17 lc rgb '#0060ad' lt 1 lw 3 pt 3 pi -1 ps 0.55 #light blue#

set key below nobox
set ylabel "Fraction"
set xlabel "time, t"
set logscale x 



set terminal postscript eps enhanced color "Helvetica" 20
set size 1.2,1

set output "Etaplot.eps"

set xr [1e-2:100]
plot "data/AllEta.dat" using 1:2 with linespoints ls 1 title 'Eta abs' ,\
"data/AllEta.dat" using 1:3 with linespoints ls 2 title 'Eta diss upp' ,\
"data/AllEta.dat" using 1:4 with linespoints ls 3 title 'Eta % useful' ,\
"data/AllEta.dat" using 1:5 with linespoints ls 4 title 'Eta abs weighted' ,\
"data/AllEta.dat" using 1:6 with linespoints ls 5 title 'Eta Ld<1' ,\
"data/AllEta.dat" using 1:7 with linespoints ls 11 title 'Eta compl path' ,\
"data/AllEta.dat" using 1:8 with linespoints ls 12 title '%' ,\
"data/AllEta.dat" using 1:9 with linespoints ls 13 title '% useful pol' ,\
"data/AllEta.dat" using 1:10 with linespoints ls 17 title '% useful fuller' 



#"phi_0.6/energy.txt" using 1:3 axis x1y1 with line title 'Homo' ,\
#"phi_0.6/energy.txt" using 1:4 axis x1y1 with line title 'Interfacial' ,\

#set output "compare_phi_energy.eps"
#set xr [1e-4:100]
#plot "phi_0.6/energy.txt" using 1:3 axis x1y1 with linespoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y2 with lines 

#set xr [1e-4:100]
#plot "phi_0.6/ts_adpt.txt" using 1:3 axis x1y1 with linespoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y1 with lines 
