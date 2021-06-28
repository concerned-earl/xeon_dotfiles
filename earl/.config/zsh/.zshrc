# General
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=500
SAVEHIST=500
setopt autocd
unsetopt beep
bindkey -v
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
autoload -Uz compinit 
compinit
_comp_options+=(globdots)       # Include hidden files.

# Light theme prompt (darker colors)
#PS1='%F{238}$ %~%F{235} '
#RPS1='%F{235}%T'

# Dark theme prompt (lighter colors)
PS1='%F{251}$ %~%F{255} '
RPS1='%F{238}%T'

# Alias
alias cp="cp -iv"
alias mv="mv -iv"
alias bc="bc -ql" # calculator
alias r="ranger"
alias rm="rm -v"
alias ka="killall"
alias v="$EDITOR"
alias sv="sudo $EDITOR"
alias sp="sudo pacman"
alias grep="grep --color=auto"
alias processes="ps aux"
alias {wp,bg}="feh --bg-fill"
alias yt="youtube-dl --add-metadata -i"
alias yta="yt -x -f bestaudio/best"
alias rss="newsboat"
alias aur="paru"
alias mkd="mkdir -pv" # -p make parent directories as needed
alias ls="ls -hN --color=auto --group-directories-first"

# Devour/swallow windows
alias mpv="devour mpv"
alias z="devour $READER"

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

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
