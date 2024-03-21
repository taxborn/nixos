{ config, pkgs, ... }:

{
  # User-level module imports.
  imports = [
    ./modules/shell.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "taxborn";
  home.homeDirectory = "/home/taxborn";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    arandr
    discord
    fd
    feh
    gcc
    gh
    google-chrome
    jdk21
    llvmPackages_17.clang-unwrapped
    neofetch
    pavucontrol
    ripgrep
    rustup
    spotify
    st
    vlc

    unstable.alacritty
    unstable.neovim
    # unstable.protonvpn-gui # eventually switch to OpenVPN config or wireshark (or wireguard?)
    # unstable.protonvpn-cli
    unstable.python312Full
    unstable.python312Packages.pip

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # TODO: Figure out a good way to include the lazy-lock.json file
    # to pin plugin versions. Right now since this symlinks to a RO
    # file system, nvim doesn't like it. Maybe since this is actually managed by HM now
    # this will work.
    # It also may be that I don't want that lock file here. Hard to keep updated.
    ".config/nvim/init.lua".source = ./dotfiles/nvim/init.lua;

    # ".config/tmux/tmux.conf".source = ./dotfiles/tmux/tmux.conf;

    ".background-image".source = ./dotfiles/wallpapers/lakeside.png;

    ".config/alacritty" = {
      source = ./dotfiles/alacritty;
      recursive = true;
    };

    ".config/i3/config" = {
      source = ./dotfiles/i3/config;
      force = true; # There may be a more general way to do this:
                    # https://github.com/nix-community/home-manager/issues/4199
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/taxborn/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    lazygit.enable = true;

    git = {
      enable = true;
      lfs.enable = true;

      userName = "Braxton Fair";
      userEmail = "hello@taxborn.com";

      signing.key = "CA973F0FD0F2AF3A";
      signing.signByDefault = true;

      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
    };

    # fish = {
    #   enable = true;
    #
    #   shellAliases = {
    #     rbld = "sudo nixos-rebuild switch --flake /home/taxborn/dev/code/nixos/#$(hostname)";
    #     dl-repos = "gh repo list taxborn --source --json nameWithOwner -q \".[].nameWithOwner\" | xargs -L1 gh repo clone";
    #     vim="nvim";
    #     vi="nvim";
    #   };
    # };

    tmux.enable = true;

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
