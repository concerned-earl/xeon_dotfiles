#!/bin/sh

maim --select $HOME/Pictures/screenshots/area/$(date +%a-%d-%b-%H-%M-%S).png && notify-send "Saved screenshot"
