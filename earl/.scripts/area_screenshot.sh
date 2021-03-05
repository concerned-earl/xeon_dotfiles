#!/bin/bash

maim --select $HOME/Pictures/screenshots/cache/$(date +%a-%d-%b-%H-%M-%S).png && notify-send "Saved screenshot"
