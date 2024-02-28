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

  # TODO: Auto mount /dev/sda1 to ~/data (for now - what's the convention now?)

  environment.interactiveShellInit = ''
    alias rebuild="sudo nixos-rebuild switch --flake /home/taxborn/dev/code/nixos/#turing"
  '';

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];
}

