#!/bin/sh

choices="browser ($BROWSER)
browser (qutebrowser)
file manager ($FILE_MANAGER)
qbittorrent
music player ($MUSIC_PLAYER)
videos
pictures
steam
notes (cherrytree)
volume control (pavucontrol)
virtualbox
screen settings (arandr)
customizing (lxappearance)
psp emulator (ppsspp)
ps1 emulator (duckstation)
libreoffice
sound editor (audacity)
password manager (keepassxc) 
obs
htop
terminal ($TERMINAL)
night light (redshift)
code
discord
"

# chosen=$(echo -e "$choices" | dmenu -i -fn "Terminus:size=15" -nb "#000000" -nf "#ffffff" -sb "#ffffff" -sf "#000000")
chosen=$(echo -e "$choices" | dmenu -i -fn "DejaVu Sans Mono:size=13" -nb "#000000" -nf "#ffffff" -sb "#ffffff" -sf "#000000")

case $chosen in
    "browser ($BROWSER)") $BROWSER ;;
    "browser (qutebrowser)") qutebrowser ;;
    "file manager ($FILE_MANAGER)") $FILE_MANAGER ;;
    qbittorrent) qbittorrent ;;
    "music player ($MUSIC_PLAYER)") $HOME/.scripts/mpd.sh && $TERMINAL -e $MUSIC_PLAYER ;;
    pictures) $FILE_MANAGER $HOME/Pictures ;;
    videos) $FILE_MANAGER $HOME/Videos ;;
    steam) steam ;;
    "notes (cherrytree)") cherrytree ;;
    "volume control (pavucontrol)") pavucontrol ;;
    virtualbox) virtualbox ;;
    "screen settings (arandr)") arandr ;;
    "customizing (lxappearance)") lxappearance ;;
    "psp emulator (ppsspp)") PPSSPPSDL ;;
    "ps1 emulator (duckstation)") duckstation-qt ;;
    libreoffice) libreoffice ;;
    "sound editor (audacity)") audacity ;;
    "password manager (keepassxc)") keepassxc ;;
    obs) obs ;;
    htop) $TERMINAL -e htop ;;
    "terminal ($TERMINAL)") $TERMINAL ;;
    "night light (redshift)") redshift ;;
    code) vscodium ;;
    discord) discord ;;
esac
