#
# ~/.bash_profile
#

export PATH="$PATH:$HOME/.local/bin"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"
export FILE_MANAGER="thunar"
export MUSIC_PLAYER="ncmpcpp"
export VIDEO_PLAYER="mpv"
export READER="zathura"
export HISTFILE="$HOME/.config/.bash_history"
export WINDOW_MANAGER="dwm"
export LOCK_SCREEN="$HOME/Pictures/etc/lock.png"

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec startx
fi
