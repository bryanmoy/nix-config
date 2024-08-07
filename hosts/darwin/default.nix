{ agenix, config, pkgs, ... }:

let user = "bryanmoy"; in

{

  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
    ../../modules/shared/cachix
     agenix.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Tiling window manager
  services.yabai = {
    enable = true;
    config = {
      external_bar = "off:40:0";
      menubar_opacity = "1.0";
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      display_arrangement_order = "default";
      window_origin_display = "default";
      window_placement = "second_child";
      window_zoom_persist = "on";
      window_shadow = "on";
      window_animation_duration = "0.0";
      window_animation_easing = "ease_out_circ";
      window_opacity_duration = "0.0";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.90";
      window_opacity = "off";
      insert_feedback_color = "0xffd75f5f";
      split_ratio = "0.50";
      split_type = "auto";
      auto_balance = "off";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      window_gap = 06;
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    enableScriptingAddition = true;
  };

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs; [
    emacs-unstable
    agenix.packages."${pkgs.system}".default
  ] ++ (import ../../modules/darwin/packages.nix { inherit pkgs; });

  launchd.user.agents.emacs.path = [ config.environment.systemPath ];
  launchd.user.agents.emacs.serviceConfig = {
    KeepAlive = true;
    ProgramArguments = [
      "/bin/sh"
      "-c"
      "/bin/wait4path ${pkgs.emacs}/bin/emacs && exec ${pkgs.emacs}/bin/emacs --fg-daemon"
    ];
    StandardErrorPath = "/tmp/emacs.err.log";
    StandardOutPath = "/tmp/emacs.out.log";
  };

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  fonts.packages = with pkgs; [ fira-code-nerdfont ];
}
