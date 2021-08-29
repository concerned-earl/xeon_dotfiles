#!/bin/sh

cat <<EOF | xmenu | sh &
Accessories
	Calculator 			qalculate-gtk
	Night Light
		4500K				redshift -P -O 4500
		5000K				redshift -P -O 5000
		5700K				redshift -P -O 5700 
		Reset				redshift -x
	RSS 				$TERM -e $RSS
	Screenshot
		Clipboard 			$HOME/.scripts/clipboard_screenshot.sh
		Select Area			$HOME/.scripts/area_screenshot.sh
		Whole Screen		$HOME/.scripts/screenshot.sh
	Torrent 			qbittorrent
Games
	Emulators
		PSP					PPSSPPSDL
		PSX					duckstation-qt
		SNES				snes9x-gtk
	Lutris				lutris
	Steam				steam
	.../Games			$FILE_MANAGER $HOME/Games
Graphics
	Davinci Resolve 	/opt/resolve/bin/resolve
	OBS					obs 
Office
	LibreOffice			libreoffice
Settings
	Display 			arandr
	Network				$TERM -e nmtui
	Nvidia				nvidia-settings
	Theme				lxappearance	

System
	Hibernate			systemctl hibernate		
	Logout				xset dpms force off ; slock
	Reboot 				reboot
	Suspend 			systemctl suspend
	Poweroff 			poweroff
EOF
