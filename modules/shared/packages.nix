{ pkgs }:

with pkgs; [
  aspell # Spell checker for many languages.
  aspellDicts.en # Aspell dictionary for English
  aspellDicts.fr # Aspell dictionary for French
  coreutils # The GNU Core Utilities.
  devenv # Fast, Declarative, Reproducible, and Composable Developer Environments.
  fastfetch # Like neofetch, but much faster because written in C.
  gobang # A cross-platform TUI database management tool written in Rust
  just # A handy way to save and run project-specific commands.
  # openssh # An implementation of the SSH protocol.
  postman # API Development Environment
  # sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine
  # wget # Tool for retrieving files using HTTP, HTTPS, and FTP
  # zip # Compressor/archiver for creating and modifying zipfiles

  # Encryption and security tools
  age # Modern encryption tool with small explicit keys
  # age-plugin-yubikey # YubiKey plugin for age
  # gnupg # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
  # libfido2 # Provides library functionality for FIDO 2.0, including communication with a device over USB.

  # Cloud-related tools and SDKs
  # docker
  # docker-compose
  kubectl # Kubernetes CLI
  kubectx # Fast way to switch between clusters and namespaces in kubectl!

  # Media-related packages
  ffmpeg # A complete, cross-platform solution to record, convert and stream audio and video.
  fd # A simple, fast and user-friendly alternative to find.
  # font-awesome # Font Awesome - OTF font.

  # Text and terminal utilities
  jq # Fast JSON parser
  ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
  zsh-powerlevel10k
]
