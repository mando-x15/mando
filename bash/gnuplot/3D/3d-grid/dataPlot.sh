#!/bin/bash

# Official colors from OpenOffice

#red
set style line 1 lc rgb '#FCAE91' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 2 lc rgb '#FB6A4A' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 3 lc rgb '#DE2D26' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 4 lc rgb '#A50F15' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 

#blue
set style line 5 lc rgb '#BDD7E7' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 6 lc rgb '#6BAED6' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 7 lc rgb '#4D478B' lt 3 lw 0.25 pt 9 pi -1 ps 1.0 
set style line 8 lc rgb '#C85F5F' lt 3 lw 0.15 pt 7 pi -1 ps 1.0 

#green
set style line 9 lc rgb '#B2E2E2' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 10 lc rgb '#66C2A4' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 11 lc rgb '#2CA25F' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 12 lc rgb '#006D2C' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 

#orange
set style line 13 lc rgb '#FDBE85' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 14 lc rgb '#FD8D3C' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 15 lc rgb '#FD8D3C' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 
set style line 16 lc rgb '#FD8D3C' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 

set style line 17 lc rgb '#0060ad' lt 1 lw 2 pt 7 pi -1 ps 1.5 #light blue#
set style line 18 lc rgb '#000000' lt 1 lw 1 pt 1 pi -1 ps 1.0 #black dot

set style line 19 lc rgb '#8B0000' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 # ---darkRed dotted
set style line 20 lc rgb '#0060ad' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 # --- light blue dotted
set style line 21 lc rgb '#4F974F' lt 3 lw 0.25 pt 11 pi -1 ps 1.0 
set style line 22 lc rgb '#FF7F00' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 # --- orange dotted
set style line 23 lc rgb '#74C476' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 # --- green dotted

set style line 24 lc rgb '#858585' lt 3 lw 0.25 pt 3 pi -1 ps 1.0 #black dotted

set terminal postscript eps enhanced color "Helvetica" 13

set out 'PS-total.eps'

set size 1.5,1.5


#set grid xtics ytics ztics
#set grid ls 23 

#set mytics 2
#set mxtics 2
#set mztics 2

#set min/max values
xmin = -100; xmax = 50;
ymin = -50; ymax = 100;
zmin = -80; zmax = 80;
set xrange [xmin: xmax]
set yrange [ymin: ymax]
set zrange [zmin: zmax]


#show view 
set view 65,50,1

set ticslevel 0.0
unset tics
set multiplot
unset grid
set border 0

set format x ""
set format y ""
set format z ""

set isosamples 10,10

set parametric

set urange [ymax:ymin]
set vrange [zmax:zmin]
splot xmin,u,v w lines ls 24 notitle

set urange [xmin:xmax]
set vrange [zmin:zmax]
splot u,ymax,v w lines ls 24 notitle

set urange [xmin:xmax]
set vrange [ymin:ymax]
splot u,v,zmin w lines ls 24 notitle

unset parametric


#axes
set format y "  %g"
set format x "  %g"
set format z "  %g"

set xtics nomirror offset 1,-0.25
set ytics nomirror offset 1,-0.15
set ztics nomirror offset 1,1

set xlabel "X axis" offset -1,-1
set ylabel "Y axis" offset -1,-1
set zlabel "Z axis"

set key top right
set title "Dr data"
splot "data.txt" using 1:2:3 every ::1::28 with linespoints ls 4 title 'allp' ,\
"data.txt" using 1:2:3 every ::29::57 with linespoints ls 4 notitle ,\
"data.txt" using 1:2:3 every ::58::85 with linespoints ls 4 notitle ,\
"data.txt" using 1:2:3 every ::86::113 with linespoints ls 4 notitle ,\
"data.txt" using 1:2:3 every ::113::140 with linespoints ls 18 title 'homo' ,\
"data.txt" using 1:2:3 every ::141::169 with linespoints ls 21 title 'pn18' ,\
"data.txt" using 1:2:3 every ::170::197 with linespoints ls 21 notitle ,\
"data.txt" using 1:2:3 every ::198::226 with linespoints ls 21 notitle ,\
"data.txt" using 1:2:3 every ::227::255 with linespoints ls 21 notitle ,\
"data.txt" using 1:2:3 every ::256::283 with linespoints ls 8 title 'pn25' ,\
"data.txt" using 1:2:3 every ::284::311 with linespoints ls 8 notitle ,\
"data.txt" using 1:2:3 every ::312::339 with linespoints ls 8 notitle ,\
"data.txt" using 1:2:3 every ::340::367 with linespoints ls 8 notitle ,\
"data.txt" using 1:2:3 every ::368::396 with linespoints ls 7 title 'pn31',\
"data.txt" using 1:2:3 every ::397::424 with linespoints ls 7 notitle ,\
"data.txt" using 1:2:3 every ::425::452 with linespoints ls 7 notitle ,\
"data.txt" using 1:2:3 every ::453::476 with linespoints ls 7 notitle 

unset multiplot








