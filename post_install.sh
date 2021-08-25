#!/bin/sh

to_install() {
  REPO=$(dirname $0)
  echo "enter username"
  read user
  H=/home/$user
  echo 

  echo -e "\nmove files from the repository to $H? [y/n]"
  read to_move

  echo -e "\ninstall standard packages? [y/n]"
  read to_std

  if [ $to_std = y ]; then
    echo -e "\ninstall additional standard packages (e.g. obs, libreoffice)? [y/n]"
    read to_std2

    echo -e "\ninstall aur helper (paru)? [y/n]"
    read to_paru

    if [ $to_paru = y ]; then
      echo -e "\ninstall aur packages? [y/n]"
      read to_aur
    fi

    echo -e "\ninstall video driver? [y/n]"
    read to_video

    if [ $to_video = y ]; then
      echo -e "\nchoose the video driver [nvidia/intel]"
      read video
      echo "$video has been chosen"

      if [ $video = intel ]; then
        echo -e "\nis the cpu ivy bridge or newer? [y/n]"
        read intel_vulkan
      fi
    fi
      
    echo -e "\nset shell to zsh? [y/n]"
    read to_zsh

    if [ $to_move = y ]; then
      echo -e "\ncompile software (e.g. dmenu, dwm)? [y/n]"
      read to_make
    fi

    echo -e "\nstart services (e.g. ufw)? [y/n]"
      read to_service
      echo ""
  fi
}


pre_install() {
  echo -e "follow the instructions carefully, as the script is fairly basic.\n"

  echo "prerequisites:"
  echo "-> arch installation"
  echo "-> run script as root user"
  echo "-> working internet connection"
  echo -e "-> https://github.com/concerned-earl/xeon_dotfiles cloned\n"

  to_install
}

mk_files() {
  echo -e "creating files/directories...\n"

  mkdir $H/etc
  mkdir $H/Downloads

  mkdir -p $H/Videos/anime

  mkdir -p $H/Documents/Books
  mkdir  $H/Documents/Notes
  mkdir  $H/Documents/School

  mkdir $H/Games

  mkdir -p $H/Pictures/screenshots/area
  mkdir $H/Pictures/screenshots/fullscreen
  mkdir $H/Pictures/screenshots/mpv
  mkdir $H/Pictures/wallpapers

  mkdir $H/Music
  if [ $to_std = y ]; then
    mkdir -p $H/.config/mpd/playlists
    mkdir $H/.config/mpd/lyrics
    touch $H/.config/mpd/mpd.pid
    touch $H/.config/mpd/mpdstate
    touch $H/.config/mpd/mpd.log
    touch $H/.config/mpd/mpd.db
  fi
}

mv_files() {
  echo -e "moving files from the repository to $H\n"
  mv -f $REPO/.config $H
  mv -f $REPO/.scripts $H
  mv -f $REPO/.Xresources $H
  mv -f $REPO/.zprofile $H
  mv -f $REPO/.xinitrc $H

  chmod +x $H/.scripts/*
}

install_paru() {
  echo -e "installing paru...\n"
  cd $H/etc
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd $H
}

install_video() {
  if [ $video = nvidia ]; then
    echo -e "installing nvidia drivers...\n"
    pacman -S --noconfirm --needed nvidia nvidia-utils
  elif [ $video = intel ]; then
    echo -e "installing intel drivers...\n"
    pacman -S --noconfirm --needed mesa
    if [ $intel_vulkan = y ]; then
      echo -e "installing vulkan support...\n"
      pacman -S --noconfirm --needed vulkan-intel
    fi
  fi
}

install_pkg() {
  if [ $to_std = y ]; then
    timedatectl set-ntp true
    echo -e "installing standard packages...\n"
    pacman -Syu --noconfirm --needed - < $REPO/etc/std

    if [ $to_std2 = y ]; then
      pacman -S --noconfirm --needed - < $REPO/etc/std2
    fi
  fi

  if [ $to_video = y ]; then
    install_video     
  fi

  if [ $to_paru = y ]; then
    install_paru     
  fi

  if [ $to_aur = y ]; then
    echo -e "installing AUR packages...\n"
    paru -S --noconfirm < $REPO/etc/aur
  fi

  gpasswd -a mpd $user
  chmod 710 $H/Music
}

set_zsh() {
  echo -e "setting shell to zsh...\n"
  chsh -s $(which zsh) $user
}

make_software() {
  echo -e "compiling software...\n"

  compile() {
    echo "compiling $1"
    cd $H/.config/$1
    make clean install
  }

  compile dmenu
  compile dwm
  compile dwmblocks
  compile slock
  compile st
  compile xmenu

  echo ""
}

service() {
  echo -e "starting services...\n"

  echo -e "starting ufw...\n"
  systemctl enable ufw.service
}

# ---------------------------------------

pre_install

mk_files

install_pkg


if [ $to_move = y ]; then
  mv_files
fi

if [ $to_zsh = y ]; then
  set_zsh
fi

if [ $to_make = y ]; then
  make_software
fi

if [ $to_service = y ]; then
  service
fi

echo -e "\nthe script has finished. reboot might be needed."
