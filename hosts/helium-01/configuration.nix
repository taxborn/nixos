{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "helium-01"; # Define your hostname.

  # helium-01-exclusive system packages (not recommended)
  # environment.systemPackages = with pkgs; [ ];

  programs.zsh.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?
}

