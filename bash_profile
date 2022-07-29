# .bash_profile of root user

### Set PATH
mypaths=(
  "$HOME/lib/bash_lib"
  "$HOME/bin/bash_bin"
  "$HOME/$(hostname -s)/bin"
)

# Export PATH
for mypath in "${mypaths[@]}"; do
  if [[ ! "$PATH" =~ "$mypath" ]] && [[ -d $mypath ]]; then
    export PATH="$mypath:$PATH"
  fi
done

unset mypaths mypath

### Bash History
HISTSIZE=5000
HISTFILESIZE=20000
HISTTIMEFORMAT="|%Y-%m-%d %H:%M| "
# Store bash history immediately
PROMPT_COMMAND="history -a"
HISTCONTROL="ignoreboth"

### Set aliases
alias ll="ls -lh --color"
alias ls="ls -h --color"
alias grep="grep --color"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias du="du -sh *"
alias df="df -hT"
alias tree="tree -C"
alias vi="vim"
# My aliases
alias showaliases="alias|cut -d'=' -f1"
alias lstoday="ls -al --time-style=+%D | grep --color=none $(date +%D)"
alias findname="find -print -iname "
alias findbigfiles="find . -type f -exec du -Sh {} + | sort -rh | head -n 20"
alias find100+="find . -type f -size +100M -exec ls -lh {} + | sort -rh"
alias pscpu="ps -eo pid,user,group,%cpu,%mem,rss,atime,tty8,stat,args --sort=-pcpu | head -n 10"
alias psram="ps -eo pid,user,group,%cpu,%mem,rss,atime,tty8,stat,args --sort=-rss | head -n 10"
alias meminfo='free -hlt'
alias psme="ps -eo pid,user,group,%cpu,%mem,rss,atime,tty8,stat,args --sort=user|less -S"
function findhost { grep -i "$1" ~/.ssh/config --color; }
function mygrep { grep -rnIi "$1" . --color; }
alias pingf="ping -c4 -i0.3 -W0.1 -w2"
alias ports="ss -tulpn"
function historyf { history|grep -in "$1" --color; }

### Set environment variables
export BIN="~/$(hostname -s)/bin"
export CONFIG="~/$(hostname -s)/config"
export LIB_BASH="/usr/local/bin/lib_bash"

### Custom prompt
if [[ "${LOGNAME}" = "root" ]] || [[ "$(id -u)" -eq "0" ]]; then
  case "$TERM" in
    screen*|xterm*|tmux-*)
      PS1='\[\e[0;38;5;160m\]\u@\h\e[0;38;5;215m\]$(git branch 2>/dev/null|sed -n "s/* \(.*\)/ (\1)/p")\[\e[0m\]: \e[1m\w\n\[$(tput setaf 1)\]#\[\e[0m\] '
    ;;
  esac
else
  case "$TERM" in
    screen*|xterm*|tmux-*)
      PS1='\[$(tput setaf 2)\]\u@\h\e[0;38;5;215m\]$(git branch 2>/dev/null|sed -n "s/* \(.*\)/ (\1)/p")\[\e[0m\]: \e[1m\w\n\[$(tput setaf 1)\]$\[\e[0m\] '
    ;;
  esac
fi

### Load extra bash profiles
if [[ -d ~/$(hostname -s) ]]; then
  if [[ -f ~/$(hostname -s)/config/bash_profile_$(hostname -s) ]]; then
    . ~/$(hostname -s)/config/bash_profile_$(hostname -s)
  fi
fi

if [[ -f ~/.bash_profile_$(hostname -s) ]]; then
  . ~/.bash_profile_$(hostname -s)
fi

