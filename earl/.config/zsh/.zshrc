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
PS1='%F{251}$ %~%F{255} '
RPS1='%F{238}%T'

# Alias
#alias update="paru -Syu --noconfirm && notify-send 'Update finished'" # Updates standard and AUR packages
alias r="ranger"
alias z="$READER"
alias v="$EDITOR"
alias sv="sudo $EDITOR"
alias ka="killall"
alias mkd="mkdir -pv" # -p make parent directories as needed, -v verbose
alias ls="ls -hN --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias rm="rm -v"
alias sp="sudo pacman"
alias processes="ps aux"
alias mu="~/.scripts/mpd.sh && ncmpcpp" # Start mpd (if needed) and ncmpcpp
alias {wp,bg}="feh --bg-fill"

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
