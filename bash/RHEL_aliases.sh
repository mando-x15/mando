RHEL /ect/bashrc

# ubuntu default
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
     alias ls='ls --color=auto'
     alias dir='dir --color=auto'
     alias vdir='vdir --color=auto'
     alias grep='grep --color=auto'
     alias fgrep='fgrep --color=auto'
     alias egrep='egrep --color=auto'
 fi

# Admin-set aliases
alias cds='cd /scratch'
alias cdh='cd /home'
alias cdw='cd /work1'

# core temps
alias ct='sensors | grep Core'
alias vi=vim

# more ls
alias ll="ls -lhAF"
alias la='ls -A'

# resources
alias meminfo='free -m -l -t -h'        # how much free memory
alias df='df -H'                        # HDD partition space
alias duh='du -skh * | sort -h -r'      # sort by largest-smallest 
alias top='atop'                        # processes running
alias pstat='mpstat -P ALL 5 1'         # processes running

#mk
function mk() {
make clean
make
}




