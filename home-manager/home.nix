{ config, pkgs, ... }:

{
  home.username = "xion";
  home.homeDirectory = "/home/xion";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # --- Desktop & GUI Apps ---
    kitty ghostty firefox
    neovim vesktop spotify wlogout cava pavucontrol blueberry yad
    nodejs_24 kdePackages.kdeconnect-kde

    # --- CLI Productivity ---
    fish starship axel bc coreutils curl wget rsync ripgrep jq
    playerctl cliphist wl-clipboard hyprpicker tesseract

    # --- Development & Build Tools ---
    cmake meson typescript gjs gobject-introspection glib
    tinyxml2 dart-sass

    # --- Wayland / Graphics Utilities ---
    rofi-wayland brightnessctl swww grim swappy wf-recorder gradience matugen webp-pixbuf-loader

    # --- Libraries & Theming ---
    gtk3 gtk-layer-shell libdbusmenu-gtk3 libpulseaudio libsoup_3 libnotify
    gtkmm3 gtksourceview3 gtksourceviewmm cairomm libsForQt5.qt5ct qt5.qtwayland
    adw-gtk3 bibata-cursors

    # --- Fonts ---
    rubik material-symbols noto-fonts-emoji noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono nerd-fonts.space-mono

    # --- Python Environment ---
    (python3.withPackages (ps: with ps; [
      libsass pywalfox pywal pillow build setuptools-scm
      wheel pywayland psutil metar
    ]))
  ];

  programs.foot = {
    enable = true;
    settings.main.font = "monospace:size=11";
  };

  programs.starship.enable = true;
  programs.home-manager.enable = true;

  programs.hyprlock = {
    enable = true;
    settings = {
      general = { disable_loading = true; grace = 0; };
      background = [{
        path = "/home/xion/wallpaper.png"; # Fixed path from /home/user/
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 2;
      }];
    };
  };

  services.gnome-keyring.enable = true;
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    temperature.night = 3500;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = { after_sleep_cmd = "hyprctl dispatch dpms on"; ignore_dbus_inhibit = false; };
      listener = [{ timeout = 300; on-timeout = "hyprlock"; }];
    };
  };

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
    theme = { name = "adw-gtk3"; package = pkgs.adw-gtk3; };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "adwaita-dark";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/xion/dotfiles/nvim";
  };

  home.sessionVariables = {
    # EDITOR = "neovim";
  };
}
