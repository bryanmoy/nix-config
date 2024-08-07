{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  raycast # Control your tools with a few keystrokes
  maccy # Simple clipboard manager for macOS
  arc-browser # Arc from The Browser Company
  slack # Desktop client for Slack
  zoom-us # zoom.us video conferencing application.
  dockutil # Tool for managing dock items.
  utm # Full featured system emulator and virtual machine host for iOS and macOS.
  tableplus # Database management made easy.
  # iina # The modern media player for macOS.
]
