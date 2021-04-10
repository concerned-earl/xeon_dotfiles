# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PS1="\e[0;37m\$\e[m \e[0;32m\w\e[m "

# Ignores commands that already exist in history or start with space
HISTCONTROL=ignoreboth

# Amount of last commands recorded
HISTSIZE=50

# Maximum amount of lines in .bash_history
HISTFILESIZE=2000 

# Allows to cd into directory merely by typing the directory name
shopt -s autocd 

# Enable vim mode
# set -o vi

# Disable ctrl-s and crtl-q
stty -ixon 

# Case insensitivity for TAB completion
bind "set completion-ignore-case on"

# ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# alias
alias update="paru -Syu --noconfirm && notify-send 'Update finished'" # Updates standard and AUR packages
alias r="ranger"
alias v="$EDITOR"
alias z="$READER"
alias sv="sudo $EDITOR"
alias ka="killall"
alias mkd="mkdir -pv" # -p make parent directories as needed, -v verbose
alias ls="ls -hN --color=auto --group-directories-first"
alias {wp,bg}="wal -b 000000 -i"
alias {wp_light,bg_light}="wal -b d1c7a6 -l -i"
alias grep="grep --color=auto"
alias rm="rm -v"
alias sp="sudo pacman"
alias processes="ps aux"
alias mu="~/.scripts/mpd.sh && ncmpcpp" # Start mpd (if needed) and ncmpcpp
