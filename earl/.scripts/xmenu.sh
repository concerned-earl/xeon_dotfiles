#!/bin/sh

cat <<EOF | xmenu | sh &
Launch
	Web Browser				$BROWSER
	Music Player			$HOME/.scripts/mpd.sh && $TERMINAL -e $MUSIC_PLAYER
	Video Player			$VIDEO_PLAYER
	File Manager			$FILE_MANAGER
Terminal					$TERMINAL
Screenshot
	Certain Area			maim -s | convert - \( +clone -background black -shadow 80x3+5+5 \) +swap -background none -layers merge +repage ~/Pictures/screenshots/cache/$(date +%a-%d-%b-%H-%M-%S).png | xclip -selection clipboard -t image/png; notify-send "Copied screenshot"
	Whole Screen			image=$(date +%a-%d-%b-%H-%M-%S).png && maim -m 2 -u ~/Pictures/screenshots/$image; notify-send "Screenshot" "$image"
Audio
	Toggle Volume			amixer set Master toggle
	Toggle Microphone		amixer set Capture toggle
	Settings				pavucontrol
Night Light					source ~/.scripts/env.sh && ~/.scripts/redshift.sh toggle 
Display Settings			arandr

Suspend						systemctl suspend && i3lock -i $LOCK_SCREEN -p default -f -n
Kill WM						killall $WINDOW_MANAGER
Poweroff					poweroff
Reboot						reboot
EOF
