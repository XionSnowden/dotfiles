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
  home.packages = with pkgs; [
    wofi
    hyprpaper
    waybar
    xfce.thunar
    kitty
    librewolf-bin
    neovim
    fish
    vesktop
    spotify
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

    ".config/wofi" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wofi"; recursive = true; };
    ".config/fish" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/fish"; recursive = true; };
    ".config/nvim" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim"; recursive = true; };
    ".config/waybar" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar"; recursive = true; };
    ".config/kitty" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kitty"; recursive = true; };
    ".config/hypr" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr"; recursive = true; };
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
