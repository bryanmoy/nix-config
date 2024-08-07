{ config, pkgs, lib, ... }:

let name = "Bryan Moy";
    user = "bryanmoy";
    email = "dev@bryanmoy.com";
    myAliases = {
      ls = "eza";
      ll = "eza";
      nx = "cd ~/.dotfiles/nix-config/";
      pp = "cd ~/PersonalProjects";
      qp = "cd ~/QontoProjects";
      zj = "zellij";
      ga = "git add";
      gaa = "git add --all";
      gb = "git branch";
      gbd = "git branch --delete";
      gbD = "git branch --delete --force";
      gco = "git checkout";
      gcb = "git checkout -b";
      gcam = "git commit --all --message";
      gcmsg = "git commit --message";
      gd = "git diff";
      gds = "git diff --staged";
      gl = "git pull";
      gp = "git push";
      gpf = "git push --force";
      grhh = "git reset --hard";
      grhk = "git reset --keep";
      grhs = "git reset --soft";
      gst = "git status";
    };
in
{
  nushell = {
    enable = true;
    shellAliases = myAliases // {
      ls = "ls";
      ll = "ls -al";
    };
  };

  zsh = {
    enable = true;
    shellAliases = myAliases;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
      {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./config;
          file = "p10k.zsh";
      }
    ];
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Ripgrep alias
      alias search=rg -p --glob '!node_modules/*'  $@

      # Emacs is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="emacsclient -t"
      export VISUAL="emacsclient -c -a emacs"

      e() {
          emacsclient -t "$@"
      }

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # pnpm is a javascript package manager
      alias pn=pnpm
      alias px=pnpx

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  zellij = {
    enable = true;
    settings = {};
  };

  starship = {
    enable = true;
    settings = {};
  };

  git = {
    enable = true;
    lfs = {
      enable = true;
    };
    includes = [
      {
        path = "~/Personal/.gitconfig";
        condition = "gitdir:~/.dotfiles/";
      }
      {
        path = "~/Personal/.gitconfig";
        condition = "gitdir:~/Personal/";
      }
      {
        path = "~/Work/.gitconfig";
        condition = "gitdir:~/Work/";
      }
    ];
    ignores = [
      ".direnv/"
      ".devenv*"
      "devenv.local.nix"
      ".coverage"
      "coverage.xml"
      "venv/"
      ".ropeproject/"
      ".pre-commit-config.yaml"
      ".pre-commit-config.yaml.bak"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.program = lib.mkMerge [
        (lib.mkIf pkgs.stdenv.hostPlatform.isLinux "op-ssh-sign")
        (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign")
      ];
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      push.autoSetupRemote = true;
    };
  };

  direnv = {
    enable = true;
  };

  alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        # size = lib.mkMerge [
        #   (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
        #   (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 12)
        # ];
      };
    };
  };

  # ssh = {
  #   enable = true;
  #   includes = [
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
  #       "/home/${user}/.ssh/config_external"
  #     )
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
  #       "/Users/${user}/.ssh/config_external"
  #     )
  #   ];
  #   matchBlocks = {
  #     "github.com" = {
  #       identitiesOnly = true;
  #       identityFile = [
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
  #           "/home/${user}/.ssh/id_github"
  #         )
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
  #           "/Users/${user}/.ssh/id_github"
  #         )
  #       ];
  #     };
  #   };
  # };

  helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
      };
    };
    languages = {
      language-server.pylsp.config.pylsp.plugins = {
        rope_autoimport = {
          enabled = true;
        };
      };
      language = [
        {
          name = "python";
          auto-format = true;
        }
      ];
    };
    defaultEditor = true;
  };

  awscli = {
    enable = true;
  };

  eza = {
    enable = true;
    extraOptions = [
      # Display options
      # https://github.com/eza-community/eza#display-options
      "--long"
      "--classify=always"

      # Filtering options
      # https://github.com/eza-community/eza#filtering-options
      "--all"
      "--group-directories-first"

      # Long view options
      # https://github.com/eza-community/eza#long-view-options
      "--binary"
      "--group"
      "--header"
      "--time-style=long-iso"
    ];
  };

  bat = {
    enable = true;
  };

  btop = {
    enable = true;
    settings = {};
  };
}
