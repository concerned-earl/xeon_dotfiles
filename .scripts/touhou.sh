#!/bin/sh

# Temporarily changes key inputs for Touhou

# Get keycodes
# xev | sed -ne '/^KeyPress/,/^$/p'


# z to shift/walk
xmodmap -e "keycode 52 = Shift_L"

# x to z/shooting 
xmodmap -e "keycode 53 = z"

# c to x/bomb
xmodmap -e "keycode 54 = x"
