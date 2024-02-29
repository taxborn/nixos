{ config, pkgs, ... }:

{
  home.username = "taxborn";
  home.homeDirectory = "/home/taxborn";

  home.stateVersion = "23.11"; # Don't change

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    # TODO: Figure out a good way to include the lazy-lock.json file
    # to pin plugin versions. Right now since this symlinks to a RO
    # file system, nvim doesn't like it.
    ".config/nvim/init.lua".source = ../dotfiles/nvim/init.lua;

    ".background-image".source = ../dotfiles/wallpapers/lakeside.png;

    ".config/alacritty" = {
      source = ../dotfiles/alacritty;
      recursive = true;
    };

    ".config/i3/config" = {
      source = ../dotfiles/i3/config;
      force = true; # There may be a more general way to do this:
                    # https://github.com/nix-community/home-manager/issues/4199
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      userName = "Braxton Fair";
      userEmail = "hello@taxborn.com";

      signing.key = "CA973F0FD0F2AF3A";
      signing.signByDefault = true;
    };

    # So HM can manage bash and include the session variables
    fish.enable = true;

    lazygit.enable = true;

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
