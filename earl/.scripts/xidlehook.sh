#!/bin/sh

xidlehook --not-when-audio --not-when-fullscreen \
--timer 180 'xset dpms force off' 'xset dpms force on' \
--timer 300 'systemctl suspend' ''
