set style line 1  lt 1  lw 5 ps 0.5 pt 1 linecolor rgb "#7076F1"
set style line 2  lt 1  lw 5 ps 0.5 pt 2 linecolor rgb "#D12124"
set style line 3  lt 1  lw 5 ps 0.5 pt 3 linecolor rgb "#FBE249"
set style line 4  lt 1  lw 5 ps 0.5 pt 4 linecolor rgb "#39AA00"
set style line 5  lt 1  lw 5 ps 0.5 pt 5 linecolor rgb "#FF6600"
set style line 6  lt 1  lw 5 ps 0.5 pt 6 linecolor rgb "black"

set style line 11  lt 2  lw 5 ps 0.5 pt 1 linecolor rgb "#7076F1"
set style line 12  lt 2  lw 5 ps 0.5 pt 2 linecolor rgb "#D12124"
set style line 13  lt 2  lw 5 ps 0.5 pt 3 linecolor rgb "#FBE249"
set style line 14  lt 2  lw 5 ps 0.5 pt 4 linecolor rgb "#39AA00"
set style line 15  lt 2  lw 5 ps 0.5 pt 5 linecolor rgb "#FF6600"
set style line 16  lt 2  lw 5 ps 0.5 pt 6 linecolor rgb "black"

set style line 24  lt 3  lw 3 ps 0.5 pt 4 linecolor rgb "#39AA00"


set encoding iso_8859_1
set key below box 
#set xlabel ' ~t{.6\~}'
set xlabel 'sample'
set xtics nomirror rotate 
set ytics nomirror
set ylabel "{/Symbol h}"
#set xr[0.003:26]
set yr[0:1]
set size 1.2,1.0

#set logscale x

set terminal postscript eps enhanced color "Helvetica" 22


set out "AllEta.eps"
plot "AllEta.dat" using 1:2          with line ls 1 axis  x1y1 title '{/Symbol h}-abs-upp' ,\
     "AllEta.dat" using 1:5          with line ls 11 axis x1y1 title '{/Symbol h}-abs-est' ,\
     "AllEta.dat" using 1:3          with line ls 2 axis  x1y1 title '{/Symbol h}-diss-upp' ,\
     "AllEta.dat" using 1:6          with line ls 12 axis x1y1 title '{/Symbol h}-diss-est',\
     "AllEta.dat" using 1:4          with line ls 4 axis  x1y1 title '{/Symbol h}-out-upp' ,\
     "AllEta.dat" using 1:7          with line ls 14 axis  x1y1 title '{/Symbol h}-out-path' ,\
     "AllEta.dat" using 1:8          with line ls 24 axis  x1y1 title '{/Symbol h}-out-balance' ,\
     "AllEta.dat" using 1:($2*$3*$4) with line ls 6 axis  x1y1 title '{/Symbol h}-upp' ,\
     "AllEta.dat" using 1:($5*$6*$7) with line ls 16 axis  x1y1 title '{/Symbol h}-est'

