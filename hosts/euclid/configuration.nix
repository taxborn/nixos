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

  environment.interactiveShellInit = ''
    alias rebuild="sudo nixos-rebuild switch --flake /home/taxborn/dev/code/nixos/#euclid"
  '';

  services.xserver.dpi = 261; # since I got a HiDPI display
  # TODO: why is the mouse so god damn tiny

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}

