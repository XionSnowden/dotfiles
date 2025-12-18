{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "xion";
  home.homeDirectory = "/home/xion";

  # Don't change
  home.stateVersion = "24.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
 # 1. User Packages
  home.packages = with pkgs; [
    # --- Desktop & GUI Apps ---
    hyprpaper
    waybar
    xfce.thunar
    kitty
    ghostty      # Ensure you are on unstable or have the proper overlay
    librewolf-bin
    neovim
    vesktop
    spotify
    wlogout
    cava
    pavucontrol
    blueberry
    yad

    # --- CLI Productivity ---
    fish
    starship
    axel
    bc
    coreutils
    curl
    wget
    rsync
    ripgrep
    jq
    playerctl
    cliphist
    wl-clipboard
    hyprpicker
    tesseract

    # --- Development & Build Tools ---
    cmake
    meson
    npm
    typescript
    gjs
    gobject-introspection
    glib
    tinyxml2
    dart-sass

    # --- Wayland / Graphics Utilities ---
    rofi-wayland
    brightnessctl
    swww
    grim
    swappy
    wf-recorder
    gradience
    matugen
    webp-pixbuf-loader

    # --- Libraries & Theming ---
    gtk3
    gtk-layer-shell
    libdbusmenu-gtk3
    libpulse
    libsoup_3
    libnotify
    gtkmm3
    gtksourceview3
    gtksourceviewmm
    cairomm
    qt5ct
    qt5.qtwayland
    adw-gtk3
    bibata-cursors

    # --- Fonts ---
    readex-pro
    gabarito
    rubik
    material-symbols
    noto-fonts-emoji
    noto-fonts-cjk-sans
    (nerdfonts.override { fonts = [ "JetBrainsMono" "SpaceMono" ]; })

    # --- Python Environment ---
    (python3.withPackages (ps: with ps; [
      libsass
      pywalfox
      pywal
      pillow
      build
      setuptools-scm
      wheel
      pywayland
      psutil
      metar
    ]))
  ];

  # 2. Program Modules
  programs.foot = {
    enable = true;
    settings = {
      main = { font = "monospace:size=11"; };
    };
  };

  programs.starship.enable = true;

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading = true;
        grace = 0;
      };
      background = [{
        path = "/home/user/wallpaper.png"; # Ensure this file exists!
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 2;
      }];
    };
  };

  # 3. Services
  services.gnome-keyring.enable = true;

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    temperature.night = 3500;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
      listener = [{
        timeout = 300;
        on-timeout = "hyprlock";
      }];
    };
  };

  # Polkit Agent (Required for elevated GUI tasks)
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # 4. Global Theming & Config
  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "adwaita-dark";
  };
}
                  
    # vimPlugins.lazy-nvim # This is likely incorrect. lazy-nvim is a Neovim plugin manager, not a package itself.
                          # You'd manage Neovim plugins differently, often within your Neovim configuration.
    nodejs_24
    kdePackages.kdeconnect-kde

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # The .source attribute expects a path, so you need to provide it as a string.
    # Also, using `home.path` or `lib.file.mkOutOfStoreSymlink` is often preferred
    # for linking files outside the Nix store, but for direct dotfile management,
    # the string path is correct.

    # These are symlinks. Home Manager will create symlinks from the target to the source.

    
    
    ".config/nvim" = { source = config.lib.file.mkOutOfStoreSymlink "home/xion/dotfiles/nvim"; recursive = true; };
    ".config/kitty" = { source = config.lib.file.mkOutOfStoreSymlink "home/xion/dotfiles/kitty"; recursive = true; };
    ".config/waybar" = { source = config.lib.file.mkOutOfStoreSymlink "home/xion/dotfiles/waybar"; recursive = true; };
    "Pictures/Wallpapers" = { source = config.lib.file.mkOutOfStoreSymlink "home/xion/dotfiles/Wallpapers"; recursive = true; };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the # Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #   ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #   ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #   /etc/profiles/per-user/xion/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
