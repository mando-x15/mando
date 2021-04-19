#!/bin/bash

set key below nobox
set ylabel "Fraction"
set xlabel "time, t"
set logscale x 
set title "Fraction of interfacial material with continuous path vs time, t"


set terminal postscript eps enhanced color "Helvetica" 20
set size 1.2,1

set output "Eta_plot"

#set xr [1e-2:100]
#plot "pn3/data/AllEta.dat" using 1:7 with lines lw 2 title '0.5' ,\
#"pn4/data/AllEta.dat" using 1:7 with lines lw 2 title '0.66' ,\
#"pn5/data/AllEta.dat" using 1:7 with line lw 2 title '0.82' ,\
#"pn6/data/AllEta.dat" using 1:7 with lines lw 2 title '0.98' ,\
#"pn7/data/AllEta.dat" using 1:7 with lines lw 2 title '1.15' ,\
#"pn8/data/AllEta.dat" using 1:7 with lines lw 2 title '1.31' ,\
#"pn9/data/AllEta.dat" using 1:7 with lines lw 2 title '1.48' ,\
#"pn10/data/AllEta.dat" using 1:7 with lines lw 2 title '1.64' ,\
#"pn11/data/AllEta.dat" using 1:7 with lines lw 2 title '1.80' ,\
#"pn12/data/AllEta.dat" using 1:7 with lines lw 2 title '1.97' ,\
#"pn25/data/AllEta.dat" using 1:7 with lines lw 2 title '4.10' ,\
#"pn30/data/AllEta.dat" using 1:7 with lines lw 2 title '4.92'

set xr [1e-2:100]
set yr [0:1]
plot "pn4/data/AllEta.dat" using 1:7 with lines lw 3 title '0.65' ,\
"pn6/data/AllEta.dat" using 1:7 with lines lw 3 title '0.98-r1' ,\
"pn8/data/AllEta.dat" using 1:7 with lines lw 3 title '1.31' ,\
"pn6-r2/data/AllEta.dat" using 1:7 with lines lw 3 title '0.98-r2' ,\
"pn6-r3/data/AllEta.dat" using 1:7 with lines lw 3 title '0.98-r3' ,\
"ref1/data/AllEta.dat" using 1:7 with lines lw 3 title 'ref1' ,\
"ref2/data/AllEta.dat" using 1:7 with lines lw 3 title 'ref2' ,\
"ref3/data/AllEta.dat" using 1:7 with lines lw 3 title 'ref3' 


#"p9/data/AllEta.dat" using 1:7 with lines lw 2 title '1.47' ,\
#"p10/data/AllEta.dat" using 1:7 with lines lw 2 title '1.64' ,\
#"p11/data/AllEta.dat" using 1:7 with lines lw 2 title '1.80' ,\
#"p12/data/AllEta.dat" using 1:7 with lines lw 2 title '1.97' ,\

#"p7/data/AllEta.dat" using 1:7 with linespoints lw 2 title '1.15'


#"phi_0.6/energy.txt" using 1:3 axis x1y1 with line title 'Homo' ,\
#"phi_0.6/energy.txt" using 1:4 axis x1y1 with line title 'Interfacial' ,\

#set output "compare_phi_energy.eps"
#set xr [1e-4:100]
#plot "phi_0.6/energy.txt" using 1:3 axis x1y1 with linespoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y2 with lines 

#set xr [1e-4:100]
#plot "phi_0.6/ts_adpt.txt" using 1:3 axis x1y1 with linespoints title 'phi 0.6' ,\
#     "phi_0.5/ts_adpt.txt" using 1:3 axis x1y1 with lines 
