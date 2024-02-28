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

  networking.hostName = "turing";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dmenu
    feh
    gcc
    git
    home-manager
    i3 # maybe remove with i3-gaps installed?
    jdk17
    llvmPackages_17.clang-unwrapped
    neofetch
    ntfs3g
    pavucontrol
    unzip
    vlc
    wget
  ];
}

