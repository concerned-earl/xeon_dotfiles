#!/bin/sh

to_install() {
  echo "move files from $REPO to $HOME? [y/n]"
  read to_move

  echo "install standard packages? [y/n]"
  read to_std

  if [ $to_std = y ]; then
    echo "install additional standard packages (e.g. obs, libreoffice)? [y/n]"
    read to_std2

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

  mkdir $HOME/etc
  mkdir $HOME/Downloads

  mkdir -p $HOME/Videos/anime

  mkdir -p $HOME/Documents/Books
  mkdir  $HOME/Documents/Notes
  mkdir  $HOME/Documents/School

  mkdir $HOME/Games

  mkdir -p $HOME/Pictures/screenshots/area
  mkdir $HOME/Pictures/screenshots/fullscreen
  mkdir $HOME/Pictures/screenshots/mpv
  mkdir $HOME/Pictures/screenshots/mpv
  mkdir $HOME/Pictures/wallpapers

  mkdir $HOME/Music
  mkdir -p $HOME/.config/mpd/playlists
  mkdir $HOME/.config/mpd/lyrics
  touch $HOME/.config/mpd/mpd.pid
  touch $HOME/.config/mpd/mpdstate
  touch $HOME/.config/mpd/mpd.log
  touch $HOME/.config/mpd/mpd.db
  gpasswd -a mpd $USER
  chmod 710 $HOME/Music
}

mv_files() {
  echo "moving files from $REPO to $HOME"
  mv -f $REPO/.config $HOME
  mv -f $REPO/.scripts $HOME
  mv -f $REPO/.Xresources $HOME
  mv -f $REPO/.zprofile $HOME
  mv -f $REPO/.xinitrc $HOME

  chmod +x $HOME/.scripts/*
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
    pacman -S --noconfirm --needed < $HOME/etc/post_install/std_packages

    if [ $to_std2 = y ]; then
      pacman -S --noconfirm --needed < $HOME/etc/post_install/std_packages2
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
    paru -S --noconfirm < $HOME/etc/post_install/aur_packages
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

  echo "starting ufw..."
  systemctl enable ufw.service
}

# ---------------------------------------

REPO=$(dirname $0)

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
