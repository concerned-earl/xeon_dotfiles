#!/bin/sh

# Import the colors
. "$HOME/.cache/wal/colors.sh"

choices="browser ($BROWSER)
browser (qutebrowser)
file manager ($FILE_MANAGER)
qbittorrent
discord
night light (redshift)
music player ($MUSIC_PLAYER)
steam
volume control (pavucontrol)
notes (cherrytree)
virtualbox
screen settings (arandr)
customizing (lxappearance)
psp emulator (ppsspp)
ps1 emulator (duckstation)
libreoffice
sound editor (audacity)
password manager (keepassxc) 
obs
htop"

chosen=$(echo -e "$choices" | dmenu -i -fn "DejaVu Sans Mono:size=12" -nb "$color0" -nf "$color15" -sb "$color2" -sf "$color15")

case $chosen in
    "browser ($BROWSER)") $BROWSER ;;
    "browser (qutebrowser)") qutebrowser ;;
    "file manager ($FILE_MANAGER)") $FILE_MANAGER ;;
    qbittorrent) qbittorrent ;;
    discord) discord ;;
    "night light (redshift)") redshift ;;
    "music player ($MUSIC_PLAYER)") $HOME/.scripts/mpd.sh && $TERMINAL -e $MUSIC_PLAYER ;;
    steam) steam ;;
    "volume control (pavucontrol)") pavucontrol ;;
    "notes (cherrytree)") cherrytree ;;
    virtualbox) virtualbox ;;
    "screen settings (arandr)") arandr ;;
    "customizing (lxappearance)") lxappearance ;;
    "psp emulator (ppsspp)") PPSSPPSDL ;;
    "ps1 emulator (duckstation)") duckstation-qt ;;
    libreoffice) libreoffice ;;
    "sound editor (audacity)") audacity ;;
    "password manager (keepassxc)") keepassxc ;;
    obs) obs;;
    htop) $TERMINAL -e htop ;;
esac
