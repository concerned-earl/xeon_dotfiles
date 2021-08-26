#!/bin/sh

to_install() {
  REPO=$(cd $(dirname $0) && pwd)
  echo "enter username"
  read user
  H=/home/$user

  echo -e "\ncopy files from the repository to $H? [y/n]"
  read to_copy

  echo -e "\ninstall additional standard packages (e.g. obs, libreoffice)? [y/n]"
  read to_std2

  echo -e "\ninstall aur helper (paru)? [y/n]"
  echo "makepkg can't be run as root, therefore after installation" 
  echo -e "cd into $H/etc/paru and makepkg -si"
  echo -e "aur packages will be in $H/etc/xeon_dotfiles/etc/aur"
  read to_paru

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
      
  if [ $to_copy = y ]; then
    echo -e "\ncompile software (e.g. dmenu, dwm)? [y/n]"
    read to_make
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
  mkdir $H/.scripts
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
  mkdir -p $H/.config/mpd/playlists
  mkdir $H/.config/mpd/lyrics
  touch $H/.config/mpd/mpd.pid
  touch $H/.config/mpd/mpdstate
  touch $H/.config/mpd/mpd.log
  touch $H/.config/mpd/mpd.db
}

cp_files() {
  echo -e "copying files from the repository to $H\n"
  cp -r $REPO/.config/* $H/.config
  cp -r $REPO/.scripts/* $H/.scripts
  cp $REPO/.Xresources $H
  cp $REPO/.zprofile $H
  cp $REPO/.xinitrc $H

  chmod +x $H/.scripts/*
}

install_paru() {
  echo -e "installing paru...\n"
  cd $H/etc
  git clone https://aur.archlinux.org/paru.git
}

install_video() {
  if [ $video = nvidia ]; then
    echo -e "installing nvidia drivers...\n"
    pacman -S --noconfirm --needed nvidia nvidia-utils nvidia-settings
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
  timedatectl set-ntp true
  echo -e "installing standard packages...\n"
  pacman -Syu --noconfirm --needed - < $REPO/etc/std

  if [ $to_std2 = y ]; then
    pacman -S --noconfirm --needed - < $REPO/etc/std2
  fi

  if [ $to_video = y ]; then
    install_video     
  fi

  if [ $to_paru = y ]; then
    install_paru     
  fi

  gpasswd -a mpd $user
  chmod 755 $H/Music
}

set_zsh() {
  echo -e "setting shell to zsh...\n"
  chsh -s /bin/zsh $user
  rm $H/.bash_history $H/.bash_logout $H/.bash_profile $H/.bashrc
}

make_software() {
  echo -e "compiling software...\n"

  compile() {
    echo -e "\ncompiling $1\n"
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

if [ $to_copy = y ]; then
  cp_files
fi

set_zsh

if [ $to_make = y ]; then
  make_software
fi

service

mv -t $H/etc $REPO

echo -e "\nthe script has finished. reboot might be needed."
