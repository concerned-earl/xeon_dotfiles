#!/bin/sh

to_install() {
  echo "install standard packages? [y/n]"
  read to_std

  if [ $to_std = y ]
  then
    echo "install additional standard packages (e.g. obs, libreoffice)? [y/n]"
    read to_std2

  echo "install aur helper (paru)? [y/n]"
  read to_paru
  
  if [ $to_paru = y ]
  then
    echo "install aur packages? [y/n]"
    read to_aur
  fi

  echo "install video driver? [y/n]"
  read to_video

  if [ $to_video = y ]
    echo "choose the video driver [nvidia/intel]"
    read video
    echo "$video has been chosen"

    if [ $video = intel ]
    then
      echo "is the cpu ivy bridge or newer? [y/n]"
      read intel_vulkan
    fi
  fi 

  echo "set shell to zsh? [y/n]"
  read to_zsh

  echo "additional configurations (e.g. scripts, configs)? [y/n]"
  read to_additional

  echo "compile software (e.g. dmenu, dwm)? [y/n]"
  read to_make

  echo "start services (e.g. networkmanager)? [y/n]"
  read to_service
}

pre_install() {
  echo "follow the instructions carefully, the script is fairly basic.\n"

  echo "prerequisites:"
  echo "-> arch installation"
  echo "-> run script as root user"
  echo "-> working internet connection"
  echo "-> https://github.com/concerned-earl/xeon_dotfiles cloned into ~"
  echo ""

  to_install
}

install_paru() {
  echo "installing paru..."
  cd $HOME/etc
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd $HOME
}

install_video() {
  if [ $video = nvidia ]
  then
    echo "installing nvidia drivers
    pacman -S --noconfirm --needed nvidia nvidia-utils
  elif [ $video = intel ]
  then
    echo "installing intel drivers
    pacman -S --noconfirm --needed mesa
    if [ $intel_vulkan = y ]
      then
      echo "installing vulkan support"
      pacman -S --noconfirm --needed vulkan-intel
}

install_pkg() {
  if [ $to_std = y ]
  then
    echo "installing standard packages..."
    pacman -S --noconfirm --needed < $HOME/etc/post_install/std_packages

    if [ $to_std2 = y ]
    then
      pacman -S --noconfirm --needed < $HOME/etc/post_install/std_packages2
    fi

  if [ $to_video = y ]
  then
    install_video     
  fi

  if [ $to_paru = y ]
  then
    install_paru     
  fi

  if [ $to_aur = y ]
  then
    echo "installing AUR packages..."
    paru -S --noconfirm < $HOME/etc/post_install/aur_packages
  fi
}

set_zsh() {
  echo "setting shell to zsh..."
  chsh -s $(which zsh) $USER
}

music() {
  echo "configuring mpd..."
  mkdir $HOME/Music
  mkdir $HOME/.config/mpd/playlists
  mkdir $HOME/.config/mpd/lyrics
  touch $HOME/.config/mpd/mpd.pid
  touch $HOME/.config/mpd/mpdstate
  touch $HOME/.config/mpd/mpd.log
  touch $HOME/.config/mpd/mpd.db
  gpasswd -a mpd $USER
  chmod 710 $HOME/Music
}

scripts() {
  echo "configuring scripts..."
  chmod +x $HOME/.scripts/*
}

make_software() {
  echo "compiling software..."

  compile() {
    echo "compiling $1"
    cd $HOME/.config/$1
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

  echo "starting networkmanager..."
  systemctl enable NetworkManager.service

  echo "starting ufw..."
  systemctl enable ufw.service
}

# ---------------------------------------

cd $HOME

pre_install

install_pkg

if [ $to_zsh = y ]
then
  set_zsh
fi

if [ $to_additional = y ]
then
  music
  scripts
fi

if [ $to_make = y ]
then
  make_software
fi

if [ $to_service = y ]
then
  service
fi

echo "the script has finished. reboot might be needed."
