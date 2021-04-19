#!/bin/bash

# Official colors from OpenOffice
set style line 1 lt 1 lw 3 ps 0.5 pt 6 linecolor rgb "#7076F1"
set style line 2 lt 1 lw 3 ps 0.5 pt 6 linecolor rgb "#D12124"
set style line 3 lt 1 lw 3 ps 0.5 pt 6 linecolor rgb "#FBE249"
set style line 4 lt 1 lw 3 ps 0.5 pt 6 linecolor rgb "#39AA00"
set style line 5 lt 1 lw 3 ps 0.5 pt 6 linecolor rgb "#FF6600"

set style line 11 lt 1 lw 8 ps 0.55 pt 1 linecolor rgb "#4C2D9B"
set style line 12 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#770003"
set style line 13 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#F29E25"
set style line 14 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#1E8500"
set style line 15 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#AA4400"

set style line 16 lc rgb '#000000' lt 1 lw 1 pt 7 pi -1 ps 1.0 #black dot
set style line 17 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5 #light blue#

set style line 18 lc rgb '#000000' lt 1 lw 1 pt 1 pi -1 ps 1.0 #black dot

set style line 19 lc rgb '#8B0000' lt 3 lw 1 pt 1 pi -1 ps 1.0 #darkRed
set terminal postscript eps enhanced color "Helvetica" 16

set size 1,1
#set key below nobox
unset key
set grid xtics ytics ztics
set grid layerdefault  linetype -1 linecolor rgb "gray" 
set mytics 2
set mxtics 2

set title "energy"
set xlabel "time, t"
set ylabel "energy, [-]"

#set xrange [0.0001: 5]
set size 1.2,1
set logscale x

set title "time of PS"
set xlabel "energy, [-]"
set ylabel "time, t"
set autoscale x
set size 1.2,1
set logscale x


#fit parameters
a = 0.1555
b = -0.07936
f(x) = a * x ** b

fit f(x) "timeOfPS.txt" using 1:2 via a,b

set yrange [0.25: 0.5]
set title "time of PS"
set out 'PS.eps'
plot "timeOfPS.txt" using 1:2 with linespoints ls 16 title 'PS' ,\
f(x) with lines ls 19

