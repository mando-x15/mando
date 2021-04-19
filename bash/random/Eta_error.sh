#!/bin/bash

set key below nobox
set ylabel "Fraction"
set xlabel "Frequency Ratio"
set title "Eta vs Ratio, t"


set terminal postscript eps enhanced color "Helvetica" 20
set size 1.2,1
set term postscript
set output "Eta-vs-Fratio_1(no_error).ps"


set xr [0.6:1.5]
set yr [0.4:1]
plot "avg_at_time_10.txt" using 1:2 with lines lw 5 title "inter-con" ,\
"avg_at_time_10.txt" using 1:2:3 with yerrorbars lw 3 notitle ,\
"avg_at_time_10.txt" using 1:4 with lines lw 5 title "eta-diss" ,\
"avg_at_time_10.txt" using 1:4:5 with yerrorbars lw 3 notitle ,\
"avg_at_time_10.txt" using 1:6 with lines lw 5 title "eta-abs" ,\
"avg_at_time_10.txt" using 1:6:7 with yerrorbars lw 3 notitle ,\
"avg_at_time_10.txt" using 1:8 with lines lw 5 title "Useful-polymer" ,\
"avg_at_time_10.txt" using 1:8:9 with yerrorbars lw 3 notitle ,\
"avg_at_time_10.txt" using 1:10 with lines lw 5 title "Useful-fullerene" ,\
"avg_at_time_10.txt" using 1:10:11 with yerrorbars lw 3 notitle 

#"Avg.txt" using 1:4:5 with yerrorbars lw 3 notitle ,\
#"p9/data/AllEta.dat" using 1:7 with linespoints lw 2 title '1.47' ,\
#"p10/data/AllEta.dat" using 1:7 with linespoints lw 2 title '1.64' ,\
#"p11/data/AllEta.dat" using 1:7 with linespoints lw 2 title '1.80' ,\
#"p12/data/AllEta.dat" using 1:7 with linespoints lw 2 title '1.97' ,\

#"p7/data/AllEta.dat" using 1:7 with linespointspoints lw 2 title '1.15'


#"phi_0.6/energy.txt" using 1:3 axis x1y1 with line title 'Homo' ,\
#"phi_0.6/energy.txt" using 1:4 axis x1y1 with line title 'Interfacial' ,\

#set output "compare_phi_energy.eps"
#set xr [1e-4:100]
#plot "phi_0.6/energy.txt" using 1:3 axis x1y1 with linespointspoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y2 with linespoints 

#set xr [1e-4:100]
#plot "phi_0.6/ts_adpt.txt" using 1:3 axis x1y1 with linespointspoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y1 with linespoints 
