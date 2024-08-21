{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [

  # Security and authentication
  yubikey-agent

  # App and package management
  appimage-run
  gnumake
  cmake
  home-manager

  # Media and design tools
  vlc
  fontconfig
  font-manager

  # Testing and development tools
  rofi
  rofi-calc
  # postgresql
  libtool # for Emacs vterm

  # Screenshot and recording tools
  flameshot

  # Text and terminal utilities
  # feh # Manage wallpapers
  # unixtools.ifconfig
  # unixtools.netstat
  # xclip # For the org-download package in Emacs

  # File and system utilities
  # inotify-tools # inotifywait, inotifywatch - For file system events
  # libnotify
  # sqlite
  # xdg-utils

  # Other utilities
  yad # yad-calendar is used with polybar

  # PDF viewer
  # zathura

  # Music and entertainment
  # spotify
]
