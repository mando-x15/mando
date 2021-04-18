# bash aliases and simple functions

# more ls
alias ll="ls -lhAF"
alias la='ls -A'
alias vi=vim

# resources
alias meminfo='free -m -l -t -h'        # how much free memory
alias df='df -H'                        # HDD partition space
alias duh='du -skh * | sort -h -r'      # sort by largest-smallest 
alias top='atop'                        # processes running
alias pstat='mpstat -P ALL 5 1'         # processes running


# check core temps
alias ct='sensors | grep Core'

#start tecplot
function tecplot() {
	tec360
}

#start pycharm
function pycharm() {
	pycharm.sh
}


#clean
function clean() {

rm -f energy.txt snes_it.txt ts_adpt.txt M_n.txt OUT.LOG InputData.log content.txt dfrac.txt
rm -f dt.txt
rm -f *.plt
rm -f *.jpg
rm -f noise*
}

#mk
function mk() {

make clean
make
}



