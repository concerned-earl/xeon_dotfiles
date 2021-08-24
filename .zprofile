export PATH="$PATH:$HOME/.local/bin"

export BROWSER="firefox"
export EDITOR="nvim"
export VISUAL="nvim"
export FILE_MANAGER="thunar"
export MUSIC_PLAYER="ncmpcpp"
export PAGER="less"
export READER="zathura"
export RSS="newsboat"
export TERM="st"
export TORRENT="qbittorrent"
export VIDEO_PLAYER="mpv"
export WINDOW_MANAGER="dwm"
export ZDOTDIR="$HOME/.config/zsh"

# Autostart X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
    fi
