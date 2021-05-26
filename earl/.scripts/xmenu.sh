#!/bin/sh

cat <<EOF | xmenu | sh &
Launch
	Terminal				$TERMINAL
	Web Browser				$BROWSER
	Music Player			$HOME/.scripts/mpd.sh && $TERMINAL -e $MUSIC_PLAYER
	Video Player			$VIDEO_PLAYER
	File Manager			$FILE_MANAGER
Screenshot
	Clipboard Copy			$HOME/.scripts/clipboard_screenshot.sh
	Select Area				$HOME/.scripts/area_screenshot.sh
	Whole Screen			$HOME/.scripts/screenshot.sh
Audio
	Toggle Volume			amixer set Master toggle
	Toggle Microphone		amixer set Capture toggle
	Settings				pavucontrol
Night Light					source ~/.scripts/env.sh && ~/.scripts/redshift.sh toggle 
Display Settings			arandr

Lock Screen					i3lock -c 000000
Power						$HOME/.scripts/power.sh
EOF
