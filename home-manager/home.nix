{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "xion";
  home.homeDirectory = "/home/xion";

  # Don't change
  home.stateVersion = "25.11";
  
  #Allow specific unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "unityhub"
    "spotify"
    "vscode"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    xfce.thunar
    kitty
    firefox
    fish
    vesktop
    unityhub
    spotify
    gnome-extension-manager
    nodejs_24
    kdePackages.kdeconnect-kde
    neovim
    vscode
    dotnetCorePackages.sdk_9_0_1xx-bin
    obs-studio
    openshot-qt
    blender
    unzip
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
  };


  programs.vscode.userSettings = {
  "dotnetAcquisitionExtension.sharedExistingDotnetPath" = "/home/xion/.nix-profile/bin/dotnet";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # The .source attribute expects a path, so you need to provide it as a string.
    # Also, using `home.path` or `lib.file.mkOutOfStoreSymlink` is often preferred
    # for linking files outside the Nix store, but for direct dotfile management,
    # the string path is correct.

    # These are symlinks. Home Manager will create symlinks from the target to the source.

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
