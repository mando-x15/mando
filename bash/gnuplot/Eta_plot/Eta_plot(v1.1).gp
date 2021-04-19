#!/bin/bash

#plot with lines or lines points
l = 'lines'
l = 'linespoints'

#output title
set output "Etaplot.eps"
set title "Eta vs. Time,t"


# Official colors from OpenOffice
set style line 1 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#5F9EA0"
set style line 2 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#4169E1"
set style line 3 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#000080"
set style line 4 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#4B0082"
set style line 5 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#FF6600"

set style line 11 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#8B0000"
set style line 12 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#770003"
set style line 13 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#F29E25"
set style line 14 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#1E8500"
set style line 15 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#AA4400"

set style line 16 lc rgb '#000000' lt 1 lw 3 pt 3 pi -1 ps 0.55 #black
set style line 17 lc rgb '#DA70D6' lt 1 lw 3 pt 3 pi -1 ps 0.55 #light blue#

set style line 18 lc rgb '#696969' lt 2 lw 4 pt 1 pi -1 ps 0.55 #dimgray

set key below nobox

set logscale x 10

set size 1.2,1
set key below nobox

set grid xtics ytics lt 0 lc rgb "#696969" 
#set grid y2tics lt 0 lc rgb "gray" lw 0.05
set y2tics
set ytics 0.1 
set mytics 2
set terminal postscript eps enhanced color "Helvetica" 12



set ylabel "Fraction"
set y2label "# of Interfacial Edges"
set xlabel "time, t"
set xr [1e-2:1000]
#set y2range [2e3:5e3]
set yrange [0:1]


plot "data/AllEta.dat" using 1:2 with l ls 1 title 'Ld<1' ,\
"data/AllEta.dat" using 1:3 with l ls 2 title 'Ld<5' ,\
"data/AllEta.dat" using 1:4 with l ls 3 title 'Ld<10' ,\
"data/AllEta.dat" using 1:5 with l ls 4 title 'Ld<15' ,\
"data/AllEta.dat" using 1:6 with l ls 5 title 'Eta_{out} Useful' ,\
"data/AllEta.dat" using 1:7 with l ls 11 title 'Eta compl path' ,\
"data/AllEta.dat" using 1:8 with l ls 13 title '% useful pol' ,\
"data/AllEta.dat" using 1:9 with l ls 17 title '% useful ful' ,\
"data/AllEta.dat" using 1:10 with l ls 18 axes x1y2 title 'Int-Area'



#"phi_0.6/energy.txt" using 1:3 axis x1y1 with line title 'Homo' ,\
#"phi_0.6/energy.txt" using 1:4 axis x1y1 with line title 'Interfacial' ,\

#set output "compare_phi_energy.eps"
#set xr [1e-4:100]
#plot "phi_0.6/energy.txt" using 1:3 axis x1y1 with linespoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y2 with lines 

#set xr [1e-4:100]
#plot "phi_0.6/ts_adpt.txt" using 1:3 axis x1y1 with linespoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y1 with lines 
