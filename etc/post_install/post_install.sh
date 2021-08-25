#!/bin/sh

to_install() {
  REPO=$(dirname $0)
  echo "enter username"
  read user
  H=/home/$user

  echo "move files from $REPO to $H? [y/n]"
  read to_move

  echo "install standard packages? [y/n]"
  read to_std

  if [ $to_std = y ]; then
    echo "install additional standard packages (e.g. obs, libreoffice)? [y/n]"
    read to_std2
  fi

  echo "install aur helper (paru)? [y/n]"
  read to_paru
  
  if [ $to_paru = y ]; then
    echo "install aur packages? [y/n]"
    read to_aur
  fi

  echo "install video driver? [y/n]"
  read to_video

  if [ $to_video = y ]; then
    echo "choose the video driver [nvidia/intel]"
    read video
    echo "$video has been chosen"

    if [ $video = intel ]; then
      echo "is the cpu ivy bridge or newer? [y/n]"
      read intel_vulkan
    fi
  fi

  echo "set shell to zsh? [y/n]"
  read to_zsh

  if [ $to_move = y ]; then
    echo "compile software (e.g. dmenu, dwm)? [y/n]"
    read to_make
  fi

  echo "start services (e.g. ufw)? [y/n]"
  read to_service
}


pre_install() {
  echo "follow the instructions carefully, the script is fairly basic."

  echo "prerequisites:"
  echo "-> arch installation"
  echo "-> run script as root user"
  echo "-> working internet connection"
  echo "-> https://github.com/concerned-earl/xeon_dotfiles cloned"
  echo ""

  to_install
}

mk_files() {
  echo "creating files/directories"

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
  mkdir $H/Pictures/screenshots/mpv
  mkdir $H/Pictures/wallpapers

  mkdir $H/Music
  mkdir -p $H/.config/mpd/playlists
  mkdir $H/.config/mpd/lyrics
  touch $H/.config/mpd/mpd.pid
  touch $H/.config/mpd/mpdstate
  touch $H/.config/mpd/mpd.log
  touch $H/.config/mpd/mpd.db
  gpasswd -a mpd $USER
  chmod 710 $H/Music
}

mv_files() {
  echo "moving files from $REPO to $H"
  mv -f $REPO/.config $H
  mv -f $REPO/.scripts $H
  mv -f $REPO/.Xresources $H
  mv -f $REPO/.zprofile $H
  mv -f $REPO/.xinitrc $H

  chmod +x $H/.scripts/*
}

install_paru() {
  echo "installing paru..."
  cd $H/etc
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd $H
}

install_video() {
  if [ $video = nvidia ]; then
    echo "installing nvidia drivers
    pacman -S --noconfirm --needed nvidia nvidia-utils
  elif [ $video = intel ]; then
    echo "installing intel drivers
    pacman -S --noconfirm --needed mesa
    if [ $intel_vulkan = y ]; then
      echo "installing vulkan support"
      pacman -S --noconfirm --needed vulkan-intel
    fi
  fi
}

install_pkg() {
  if [ $to_std = y ]; then
    echo "installing standard packages..."
    pacman -S --noconfirm --needed < $REPO/etc/post_install/std_packages

    if [ $to_std2 = y ]; then
      pacman -S --noconfirm --needed < $REPO/etc/post_install/std_packages2
    fi
  fi

  if [ $to_video = y ]; then
    install_video     
  fi

  if [ $to_paru = y ]; then
    install_paru     
  fi

  if [ $to_aur = y ]; then
    echo "installing AUR packages..."
    paru -S --noconfirm < $H/etc/post_install/aur_packages
  fi
}

set_zsh() {
  echo "setting shell to zsh..."
  chsh -s $(which zsh) $USER
}

make_software() {
  echo "compiling software..."

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
}

service() {
  echo "starting services..."

  echo "starting ufw..."
  systemctl enable ufw.service
}

# ---------------------------------------

pre_install

mk_files

if [ $to_move = y ]; then
  mv_files
fi

install_pkg

if [ $to_zsh = y ]; then
  set_zsh
fi

if [ $to_make = y ]; then
  make_software
fi

if [ $to_service = y ]; then
  service
fi

echo "the script has finished. reboot might be needed."
