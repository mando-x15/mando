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

set style line 20 lc rgb '#0060ad' lt 1 lw 1 pt 7 ps 1.25 # --- blue
set style line 21 lc rgb '#dd181f' lt 1 lw 1 pt 5 ps 1.15 # --- red
set style line 22 lc rgb '#39AA00' lt 1 lw 1 pt 9 ps 1.6 # --- green

set style line 23 lc rgb 'gray' lt 3 lw 1 pt 1 pi -1 ps 1.0 #gray dotted



set terminal postscript eps enhanced color "Helvetica" 16

set size 1,1
set key top right

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

#results from curvefitting
#ly03
a1 = 0.1555
b1 = -0.07936
f1(x) = a1 * x ** b1

#ly04
a2 = 0.226246
b2 = -0.05095
f2(x) = a2 * x ** b2

#ly05
a3 = 0.318436
b3 = -0.0236896
f3(x) = a3 * x ** b3

#055
a4 = 0.3387
b4 = -0.01991
f4(x) = a4 * x ** b4


#06
a5 = 0.3753
b5 = -0.01247
f5(x) = a5 * x ** b5

#065
a6 = 0.4126
b6 =   -0.005622
f6(x) = a6 * x ** b6

#070
a7 = 0.4503
b7 = 0.0007147
f7(x) = a7 * x ** b7

#035
a8 =  0.1986
b8 = -0.05856
f8(x) = a8 * x ** b8

#045
a9 =  0.2672
b9 = -0.03707
f9(x) = a9 * x ** b9

set yrange [0.25: 0.5]
set title "time of PS"
set out 'PS-total.eps'
plot "Ly-0.3/timeOfPS.txt" using 1:2 with linespoints ls 20 title 'Ly-0.3' ,\
f1(x) with lines ls 19 notitle ,\
"Ly-0.4/timeOfPS.txt" using 1:2 with linespoints ls 21 title 'Ly-0.4' ,\
f2(x) with lines ls 19 notitle ,\
"Ly-0.5/timeOfPS.txt" using 1:2 with linespoints ls 22 title 'Ly-0.5' ,\
f3(x) with lines ls 19 notitle ,\
f4(x) with lines ls 23 notitle ,\
f5(x) with lines ls 23 notitle ,\
f6(x) with lines ls 23 notitle ,\
f7(x) with lines ls 23 notitle ,\
f8(x) with lines ls 23 notitle ,\
f9(x) with lines ls 23 title 'predicted'


#"predicted/PSdata-last.txt" using 4:2 with points ls 22 notitle ,\
