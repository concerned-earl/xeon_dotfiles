~/.fehbg &
xrdb -merge ~/.Xresources
setxkbmap -layout ee, -variant nodeadkeys -option caps:escape
amixer set Capture nocap                    # Mutes microphone
amixer -q set Master 11%                    # Sets volume at 11%
xbacklight -set 50                          # Sets brightness at 50%
dunst &                                     # Notifications
wal -R                                      # Colors
picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil & # Compositor
redshift &                                  # Night light
exec $WINDOW_MANAGER 
