#bash aliases and simple functions


#start tecplot
function tecplot() {
	tec360
}



#Start VPN connection
alias vpn='sudo openconnect -s /etc/vpnc-script --no-dtls vpn.iastate.edu'

# Connect to Cystorm
alias cystorm='ssh spfeife@hpcgateway.ece.iastate.edu'

# Connect to CyEnce
alias cyence='ssh spfeife@discovery.its.iastate.edu'

# Connect to Ranger
alias ranger='ssh spfeife@tg-login.ranger.tacc.teragrid.org'

# Connect to Ranch
alias ranch='ssh -l spfeife ranch.tacc.utexas.edu'

# Connect to Stampede
alias stampede='ssh spfeife@login1.stampede.tacc.utexas.edu'

# Connect to Kraken
alias kraken='ssh spfeife@kraken.nics.utk.edu'

# ssh to meisu
#alias meisu='ssh meisu@10.24.61.72'

#sync to meisu
function sync.meisu {
    rsync -arv $1 meisu@10.24.61.19:/home/meisu/Desktop
}

# Start epstopdf
function eps() {
	
files=( *.eps )
NofF=${#files[@]}

for((i=0;i<($NofF);i++)); do
	name=${files[i]}
	echo $name
	epstopdf $name
	rm $name
done 
}


#clean
function clean() {

rm -f energy.txt snes_it.txt ts_adpt.txt M_n.txt OUT.LOG InputData.log
rm -f *.plt
rm -f *.jpg
}




