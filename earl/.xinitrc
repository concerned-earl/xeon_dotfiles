# ~/.fehbg &                                  # Set background
picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil & # Compositor
setxkbmap -layout ee, -variant nodeadkeys -option caps:escape # Sets Estonian keyboard layout and changes caps to escape
xrdb -merge ~/.Xresources                   # Merge Xresources settings
xset r rate 300 50                          # Increase key speed via a rate change (e.g. good in vim)
amixer set Capture nocap                    # Mute microphone
amixer -q set Master 11%                    # Set volume at 11%
xbacklight -set 50                          # Set brightness at 50%
dunst &                                     # Notifications
wal -R                                      # Colors
redshift &                                  # Night light
dwmblocks &                                 # Status bar
exec $WINDOW_MANAGER                        # Window manager
