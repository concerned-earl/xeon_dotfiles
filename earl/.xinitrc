~/.fehbg &                                  # Restore background
picom -b &                                  # Compositor
xrdb -merge ~/.Xresources                   # Merge Xresources settings
xset r rate 300 50                          # Increase key speed via a rate change (e.g. quicker movement in vim)
~/.scripts/keyboard.sh &                    # Set Estonian keyboard layout and changes caps to escape
amixer set Capture nocap                    # Mute microphone
amixer -q set Master 11%                    # Set volume at 11%
xbacklight -set 50                          # Set brightness at 50%
dunst &                                     # Notifications
mpd &                                       # Start mpd
dwmblocks &                                 # Status bar
thunar --daemon &                           # File manager (automatic mounting)
~/.scripts/xidlehook.sh &                   # Power saving
exec $WINDOW_MANAGER                        # Window manager
