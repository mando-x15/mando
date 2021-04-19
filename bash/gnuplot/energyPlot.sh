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

set style line 16 lc rgb '#000000' lt 1 lw 2 pt 5 pi -1 ps 1.5 #black
set style line 17 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5 #light blue#

set terminal postscript eps enhanced color "Helvetica" 16

set size 1,1
set key below nobox
set grid xtics ytics ztics
set grid layerdefault  linetype -1 linecolor rgb "gray" 
set mytics 2
set mxtics 2

set title "e4"
set xlabel "time, t"
set ylabel "energy, [-]"

set yrange [0:0.02]
set y2range [1e-5:10]
set xrange [0.001: 20]
set size 1.2,1
set logscale x

set y2label "ts"
set y2tics
#set autoscale y2
set logscale y2

set out 'e4.eps'
plot "e4/energy.txt" using 1:2 with linespoints ls 1 title 'e4' ,\
"e4/energy.txt" using 1:3 with linespoints ls 1 ,\
"e4/energy.txt" using 1:4 with linespoints ls 1  ,\
"e4/ts_adpt.txt" using 1:2 with linespoints ls 1 axes x1y2 ,\
"e8/energy.txt" using 1:2 with linespoints ls 2 title 'e8' ,\
"e8/energy.txt" using 1:3 with linespoints ls 2 ,\
"e8/energy.txt" using 1:4 with linespoints ls 2 ,\
"e8/ts_adpt.txt" using 1:2 with linespoints ls 2 axes x1y2 ,\
"e14/energy.txt" using 1:2 with linespoints ls 5 title 'e14' ,\
"e14/energy.txt" using 1:3 with linespoints ls 5 ,\
"e14/energy.txt" using 1:4 with linespoints ls 5 ,\
"e14/ts_adpt.txt" using 1:2 with linespoints ls 5 axes x1y2








