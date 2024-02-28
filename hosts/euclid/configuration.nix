# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include the default nix configuration
      ../../nix
    ];

  networking.hostName = "euclid";

  services.xserver.dpi = 180; # since I got a HiDPI display

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password-gui
    alacritty
    dmenu
    feh
    gcc
    git
    google-chrome
    home-manager
    i3
    llvmPackages_17.clang-unwrapped
    neofetch
    neovim
    pavucontrol
    spotify
    unzip
    wget
  ];
}

