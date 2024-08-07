{ pkgs, config, ... }:

let
  liguriaPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVpvtJWd7sdXiDay0p3s4ZS6erjsCeeJuyXijvkihTc";
  calabriaPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPvMq/Zpl7z9G5EOv9lfI7XK+U4SnNSq9PMGU6Kv7SaC";
  v270nw34lgPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIPIMS9BLKjX1mGPdGaREThg48e6I5+QbMbzYWV4nHoU";
in
{
  ".ssh/allowed_signers" = {
    text = ''
      * ${v270nw34lgPublicKey}
      * ${liguriaPublicKey}
      * ${calabriaPublicKey}
    '';
  };

  # TODO: Add SSH Key by host
  ".config/1Password/ssh/agent.toml" = {
    text = ''
      [[ssh-keys]]
      item = "SSH Key (macOS - Liguria)"
      vault = "Bryan"

      [[ssh-keys]]
      item = "SSH Key (NixOS - Calabria)"
      vault = "Bryan"

      [[ssh-keys]]
      item = "SSH Key (Qonto)"
      vault = "Qonto"
    '';
  };

  "Personal/.gitconfig" = {
    text = ''
    [user]
	  	name = Bryan Moy
	  	email = dev@bryanmoy.com
	  	signingkey = ${liguriaPublicKey}
    '';
  };

  "Work/.gitconfig" = {
    text = ''
    [user]
    	name = Bryan Moy
    	email = bryan.moy@qonto.com
	  	signingkey = ${v270nw34lgPublicKey}

    [init]
    	defaultBranch = "master"
    '';
  };

  # Initializes Emacs with org-mode so we can tangle the main config
  ".emacs.d/init.el" = {
    text = builtins.readFile ../shared/config/emacs/init.el;
  };
}
