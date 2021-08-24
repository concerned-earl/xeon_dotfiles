#!/bin/sh

choices="browser ($BROWSER)
browser (qutebrowser)
file manager
torrent
steam
lutris
notes
virtualbox
rss
obs
code
discord
.../videos
.../pictures
.../school"

chosen=$(echo -e "$choices" | dmenu -i) 

case $chosen in
    "browser ($BROWSER)") $BROWSER ;;
    "browser (qutebrowser)") qutebrowser ;;
    "file manager") $FILE_MANAGER ;;
    torrent) $TORRENT ;;
    steam) steam ;;
    lutris) lutris ;;
    notes) cherrytree ;;
    virtualbox) virtualbox ;;
    rss) $TERM -e $RSS ;;
    obs) obs ;;
    code) vscodium ;;
    discord) discord ;;
    ".../videos") $FILE_MANAGER $HOME/Videos ;;
    ".../pictures") $FILE_MANAGER $HOME/Pictures ;;
    ".../school") $FILE_MANAGER $HOME/Documents/School ;;
esac
