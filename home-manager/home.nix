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
    ".config/nvim" = {
      source = ../dotfiles/nvim;
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
    bash.enable = true;

    lazygit.enable = true;

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
