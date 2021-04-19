#!/bin/bash

# Official colors from OpenOffice
set style line 1 lt 1 lw 1 ps 0.5 pt 2 linecolor rgb "#7076F1"
set style line 2 lt 1 lw 1 ps 0.5 pt 2 linecolor rgb "#D12124"
set style line 3 lt 1 lw 1 ps 0.5 pt 2 linecolor rgb "#FBE249"
set style line 4 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#39AA00"
set style line 5 lt 1 lw 3 ps 0.5 pt 3 linecolor rgb "#FF6600"

set style line 11 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#4C2D9B"
set style line 12 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#770003"
set style line 13 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#F29E25"
set style line 14 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#1E8500"
set style line 15 lt 1 lw 3 ps 0.55 pt 3 linecolor rgb "#AA4400"

set style line 16 lc rgb '#000000' lt 1 lw 3 pt 3 pi -1 ps 0.55 #black
set style line 17 lc rgb '#0060ad' lt 1 lw 3 pt 3 pi -1 ps 0.55 #light blue#


set key below
set title font "Helvetica,18" 
set ylabel "X" font "Helvetica,16" offset -3
set xlabel "time, t" font "Helvetica,16" offset 2
set zlabel "Mat'l Fraction" font "Helvetica,16" offset 7 rotate by 90

set logscale x 
set zrange[0:1]
set ztics 0.1
set xtics offset -2
set ytics offset 2
set mztics 2
set ytics 0.01


set terminal postscript eps enhanced color "Helvetica" 12
set size 1.2,1

set grid front xtics ytics ztics lt 0 lc rgb "gray"
set xyplane at 0.0
set palette defined ( 0 0 0 0, 1 1 1 1 )

set dgrid3d 100, 40

set hidden3 back offset 1 trianglepattern 3 undefined 1 altdiagonal bentover
set style data lines
#set pm3d

set out "plt/2Eta_abs.eps"
set title "Eta_{abs}"
splot "data.dat" using 2:1:3 ls 2 title "Eta_{abs}"

set title "Ld<10"
set out "plt/3Eta_diss.eps"
splot "data.dat" using 2:1:4 ls 2 title "Ld<10"

set title "Eta_{useful}"
set out "plt/4Eta_useful.eps"
splot "data.dat" using 2:1:5 ls 2 title "Eta_{useful}"

set title "Eta_{absw}"
set out "plt/5Eta_absw.eps"
splot "data.dat" using 2:1:6 ls 2 title "Eta_{absw}"

set title "Ld<1"
set out "plt/6Eta_Ld1.eps"
splot "data.dat" using 2:1:7 ls 2 title "Ld<1"

set title "Eta_{cont}"
set out "plt/7Eta_cont.eps"
splot "data.dat" using 2:1:8 ls 2 title "Eta_{cont}"

set out "plt/8.eps"
splot "data.dat" using 2:1:9 ls 2 title "?"

set title "Eta_{usefulPol}"
set out "plt/9Eta_usefulPol.eps"
splot "data.dat" using 2:1:10 ls 2 title "Eta_{usefulPol}"

set title "Eta_{usefulFul}"
set out "plt/10Eta_usefulFul.eps"
splot "data.dat" using 2:1:11 ls 2 title "Eta_{usefulFul}"

unset pm3d
set out "plt/multi.eps"
splot "data.dat" using 2:1:4 ls 1 title "Ld<10" ,\
"data.dat" using 2:1:8 ls 2 title "Eta_{cont}" ,\
"data.dat" using 2:1:11 ls 3 title "Eta_{usefulFul}" 

