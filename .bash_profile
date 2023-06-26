# .bash_profile of root user

export LANG=C.UTF-8
export LC_ALL=C.UTF-8

### Set PATH
mypaths=(
  "$HOME/lib/bash_lib"
  "$HOME/bin/bash_bin"
  "$HOME/$(hostname -s)/bin"
  "$HOME/bin"
  "$HOME/linux_home_root/bin"
)

# Export PATH
for mypath in "${mypaths[@]}"; do
  if [[ ! "$PATH" =~ "$mypath" ]] && [[ -d $mypath ]]; then
    export PATH="$mypath:$PATH"
  fi
done

unset mypaths mypath

### Bash History
HISTSIZE= # unlimited
HISTFILESIZE= # unlimited
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
alias diff="diff -EZBbw"
alias less="less -R"
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

function gc-add { git commit -m "add: ${*:-'add file'} :rocket:"; }
function gc-delete { git commit -m "delete: ${*:-'remove file'} :x:"; }
function gc-update { git commit -m "update: ${*:-'update file'} :arrow_up:"; }
function gc-rename { git commit -m "rename: ${*:-'rename file'} :truck:"; }
function gc-feature { git commit -m "feature: ${*:-'add feature'} :sparkles:"; }
function gc-fix { git commit -m "fix: ${*:-'fix problem'} :adhesive_bandage:"; }
function gc-revert { git commit -m "revert: ${*:-'revert'} :rewind:"; }
function gc-refactor { git commit -m "refector: ${*:-'refector code'} :hammer:"; }
function gc-docs { git commit -m "docs: ${*:-'improve documentation'} :books:"; }
function gc-style { git commit -m "style: ${*:-'improve style'} :art:"; }
function gc-format { git commit -m "format: ${*:-'format code'} :triangular_ruler:"; }
function gc-test { git commit -m "test: ${*:-'test'} :white_check_mark:"; }
function gc-perf { git commit -m "perf: ${*:-'improve performance'} :racehorse:"; }
function gc-ci { git commit -m "ci: ${*:-'improve ci'} :construction_worker:"; }
function gc-sec { git commit -m "sec: ${*:-'improve security'} :lock:"; }
function gc-init { git commit --allow-empty -m "init: ${*:-'first commit'} :tada:"; }

### Set environment variables
export TERM=xterm-256color
export EDITOR=vim
export BIN="~/$(hostname -s)/bin"
export CONFIG="~/$(hostname -s)/config"
export LIB_BASH="~/lib/bash_lib"

### Custom prompt
if [[ "${LOGNAME}" = "root" ]] || [[ "$(id -u)" -eq "0" ]]; then
  case "$TERM" in
    screen*|xterm*|tmux-*)
      PS1='\[$(tput setaf 9)\]\u@\h\[$(tput setaf 3)\]$(git branch 2>/dev/null|sed -n "s/* \(.*\)/ [\1]/p")\[$(tput sgr0)\]: \[$(tput setaf 7)\]\w\n\[$(tput setaf 9)\]#\[$(tput sgr0)\] '
    ;;
  esac
else
  case "$TERM" in
    screen*|xterm*|tmux-*)
      PS1='\[$(tput setaf 85)\]\u@\h\[$(tput setaf 3)\]$(git branch 2>/dev/null|sed -n "s/* \(.*\)/ [\1]/p")\[$(tput sgr0)\]: \[$(tput setaf 81)\]\w\n\[$(tput setaf 85)\]$\[$(tput sgr0)\] '
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

