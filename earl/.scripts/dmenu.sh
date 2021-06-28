#!/bin/sh

choices="browser ($BROWSER)
browser (qutebrowser)
file manager ($FILE_MANAGER)
torrent
music player ($MUSIC_PLAYER)
steam
notes (cherrytree)
virtualbox
screen settings (arandr)
customizing (lxappearance)
psp emulator (ppsspp)
ps1 emulator (duckstation)
calculator
libreoffice
rss
password manager (keepassxc) 
obs
night light (redshift)
code
davinci resolve
discord
.../videos
.../pictures
.../school"

# chosen=$(echo -e "$choices" | dmenu -i -fn "Terminus:size=13" -nb "#000000" -nf "#ffffff" -sb "#ffffff" -sf "#000000")
chosen=$(echo -e "$choices" | dmenu -i -fn "DejaVu Sans Mono:size=13" -nb "#000000" -nf "#ffffff" -sb "#ffffff" -sf "#000000")

case $chosen in
    "browser ($BROWSER)") $BROWSER ;;
    "browser (qutebrowser)") qutebrowser ;;
    "file manager ($FILE_MANAGER)") $FILE_MANAGER ;;
    torrent) $TORRENT ;;
    "music player ($MUSIC_PLAYER)") $HOME/.scripts/mpd.sh && $TERMINAL -e $MUSIC_PLAYER ;;
    steam) steam ;;
    "notes (cherrytree)") cherrytree ;;
    virtualbox) virtualbox ;;
    "screen settings (arandr)") arandr ;;
    "customizing (lxappearance)") lxappearance ;;
    "psp emulator (ppsspp)") PPSSPPSDL ;;
    "ps1 emulator (duckstation)") duckstation-qt ;;
    libreoffice) libreoffice ;;
    rss) $TERMINAL -e $RSS ;;
    calculator) qalculate-gtk ;;
    "password manager (keepassxc)") keepassxc ;;
    obs) obs ;;
    "night light (redshift)") redshift ;;
    code) vscodium ;;
    "davinci resolve") /opt/resolve/bin/resolve ;;
    discord) discord ;;
    ".../videos") $FILE_MANAGER $HOME/Videos ;;
    ".../pictures") $FILE_MANAGER $HOME/Pictures ;;
    ".../school") $FILE_MANAGER $HOME/Documents/School ;;
esac
