{ config, lib, pkgs, ... }:

{
  home.username = lib.mkDefault "taxborn";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # taxborn packages I want everywhere
  # home.packages = with pkgs; [ ];

  # If you are looking for my dotfiles, look at https://github.com/taxborn/dotfiles
  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      default-cache-ttl 84000
      max-cache-ttl 84000
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "hello@taxborn.com";
    userName = "Braxton Fair";
    signing = {
      key = "9BC40CD3E8BA5EF2";
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}