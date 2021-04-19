set style fill transparent solid 0.50 noborder
set style fill solid 0.5 noborder
set style data filledcurves

# Official colors from OpenOffice
set style line 1 lt 1 lw 5 ps 0.5 pt 1 linecolor rgb "#7076F1"
set style line 2 lt 1 lw 5 ps 0.5 pt 6 linecolor rgb "#D12124"
set style line 3 lt 1 lw 5 ps 0.5 pt 6 linecolor rgb "#FBE249"
set style line 4 lt 1 lw 5 ps 0.5 pt 6 linecolor rgb "#39AA00"
set style line 5 lt 1 lw 5 ps 0.5 pt 6 linecolor rgb "#FF6600"

set style line 11 lt 1 lw 8 ps 0.55 pt 1 linecolor rgb "#4C2D9B"
set style line 12 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#770003"
set style line 13 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#F29E25"
set style line 14 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#1E8500"
set style line 15 lt 1 lw 8 ps 0.55 pt 6 linecolor rgb "#AA4400"


set key below box lw 0.1
# set key box at 0,0
#set size 0.95,0.95

set ytics 0,0.1 nomirror

set xlabel "data sets"
set terminal pdf enhanced font "NimbusSansL-Regu,9"

set ylabel "{/Symbol h}_{abs}"
set output "Eta-abs.eps"

plot "GraSPI_all_efficiencies.dat" using :10 with points ls 1 title 'GraSPI {/Symbol h}_{abs}',\
	"OSCSIM_all_efficiencies.dat" using :1 with points ls 2 title 'oscsim {/Symbol h}_{abs}'
	
	
set ylabel "{/Symbol h}_{diss}"
set output "Eta-diss.eps"

plot "GraSPI_all_efficiencies.dat" using :2 with points ls 1 title 'GraSPI {/Symbol h}_{diss} 10',\
	 "OSCSIM_all_efficiencies.dat" using :2 with points ls 2 title 'oscsim {/Symbol h}_{diss}'	
	

set ylabel "{/Symbol h}_{diss}"
set output "Eta-IntArea.eps"

plot "GraSPI_all_efficiencies.dat" using :3 with points ls 1 title 'GraSPI {/Symbol h}_{diss} 1',\
	 "OSCSIM_all_efficiencies.dat" using :3 with points ls 2 title 'oscsim AFRAC',\
     "OSCSIM_all_efficiencies.dat" using :2 with points ls 3 title 'oscsim {/Symbol h}_{diss}'	


set ylabel "{/Symbol h}_{out}"
set output "Eta-out-conn.eps"

plot "GraSPI_all_efficiencies.dat" using :5 with points ls 3 title 'GraSPI {/Symbol h}_{out}^{conn} - pol',\
	 "GraSPI_all_efficiencies.dat" using :6 with points ls 4 title 'GraSPI {/Symbol h}_{out}^{conn} - full',\
	 "OSCSIM_all_efficiencies.dat" using :8 with points ls 2 title 'oscsim {/Symbol h} anode',\
	 "OSCSIM_all_efficiencies.dat" using :9 with points ls 5 title 'oscsim {/Symbol h} cathode'
	

set ylabel "{/Symbol h}_{out}"
set output "Eta-out-path.eps"

plot "GraSPI_all_efficiencies.dat" using :7 with points ls 1 title 'GraSPI {/Symbol h}_{out}^{path}',\
	 "GraSPI_all_efficiencies.dat" using :11 with points ls 3 title 'GraSPI tortuosity',\
	 "OSCSIM_all_efficiencies.dat" using :($4/100) with points ls 2 title 'oscsim {/Symbol h}'	
	

set ylabel "{/Symbol h}"
set output "Eta-abs-diss.eps"

plot "GraSPI_all_efficiencies.dat" using :8 with points ls 1 title 'GraSPI {/Symbol h} abs+diss',\
	 "OSCSIM_all_efficiencies.dat" using :2 with points ls 2 title 'oscsim {/Symbol h} diss'	


set ylabel "{/Symbol h}"
set output "Eta-final.eps"

plot "GraSPI_all_efficiencies.dat" using :9        with points ls 1 title 'GraSPI {/Symbol h}',\
	 "OSCSIM_all_efficiencies.dat" using :($4/100) with points ls 2 title 'oscsim {/Symbol h}'	


set ylabel "{/Symbol h}"
set y2label "Jsc"
set y2tics -100,10 nomirror
set output "Eta-out-oscsim.eps"
plot "OSCSIM_all_efficiencies.dat" using :7 with points ls 4 axis x1y2 title 'oscsim Jsc',\
	 "OSCSIM_all_efficiencies.dat" using :($4/100) with points ls 2 title 'oscsim {/Symbol h}'	

set ylabel "{/Symbol h}"
unset y2label
unset y2tics
set output "Eta-abs-diss-GraSPI.eps"

plot "GraSPI_all_efficiencies.dat" using :1 with points ls 1  title 'GraSPI {/Symbol h}_{abs}',\
	 "GraSPI_all_efficiencies.dat" using :2 with points ls 3  title 'GraSPI {/Symbol h}_{diss} 10',\
	 "GraSPI_all_efficiencies.dat" using :3 with points ls 4  title 'GraSPI {/Symbol h}_{diss} 1',\
	 "OSCSIM_all_efficiencies.dat" using :($4/100) with points ls 2 title 'oscsim {/Symbol h}'	

set output "Eta-out-GraSPI.eps"
plot "GraSPI_all_efficiencies.dat" using :4 with points ls 5  title 'GraSPI {/Symbol h}_{out}^{conn}',\
	 "GraSPI_all_efficiencies.dat" using :5 with points ls 11 title 'GraSPI {/Symbol h}_{out}^{conn} P',\
	 "GraSPI_all_efficiencies.dat" using :6 with points ls 12 title 'GraSPI {/Symbol h}_{out}^{conn} F',\
	 "GraSPI_all_efficiencies.dat" using :7 with points ls 13 title 'GraSPI {/Symbol h}_{out}^{path}',\
	 "GraSPI_all_efficiencies.dat" using :11 with points ls 14 title 'GraSPI toruosity',\
	 "OSCSIM_all_efficiencies.dat" using :($4/100) with points ls 2 title 'oscsim {/Symbol h}'	

set ylabel "{/Symbol h} out - A C"
set logscale y
set output "Eta-out-oscsim-AC.eps"
plot "OSCSIM_all_efficiencies.dat" using :8 with points ls 3 title 'oscsim {/Symbol h}_{out}A ',\
	 "OSCSIM_all_efficiencies.dat" using :9 with points ls 4 title 'oscsim {/Symbol h}_{outC}'


unset logscale y

set ylabel "{/Symbol h}"
unset y2label
set ytics 0,10 nomirror
set xtics rotate
set xlabel "GraSPI {/Symbol h}
set ylabel "OSCSim Jsc"
set output "Corr-Eta-Jsc.eps"
plot "all_efficiencies.dat" using 9:(-1.0*$17) with points ls 5  notitle ,\
	 "all_efficiencies.dat" using ($20*$10*$3):(-1.0*$17) with points ls 6  title 'with Tor'


set ylabel "{/Symbol h}"
set xlabel "Graspi - eta abs"
set ylabel "OSCSim - eta abs"
set xr[0.3:0.4]
set xtics 0, 0.2
set ytics 0, 0.2
set yr[0.1:0.5]
set output "Corr-Eta-Abs.eps"
plot "all_efficiencies.dat" using 10:11 with points ls 5  notitle


set ylabel "{/Symbol h}"
set xlabel "Graspi - eta diss"
set ylabel "OSCSim - eta diss"
set xr[0:1]
set yr[0:1]
set output "Corr-Eta-Diss.eps"
plot "all_efficiencies.dat" using 2:12 with points ls 5  notitle





