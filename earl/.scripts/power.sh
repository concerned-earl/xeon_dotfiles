#!/bin/sh

choices="suspend
poweroff
kill wm
reboot"

chosen=$(echo -e "$choices" | dmenu -i -fn "DejaVu Sans Mono:size=13" -nb "#000000" -nf "#ffffff" -sb "#ffffff" -sf "#000000")

case $chosen in
    suspend) systemctl suspend ;;
    poweroff) poweroff ;;
    "kill wm") killall $WINDOW_MANAGER ;;
    reboot) reboot ;;
esac
