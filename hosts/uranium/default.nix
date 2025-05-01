# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.default

    ../common
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "uranium";
  programs.steam.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.hyprland.enable = true;
  programs.fuse.userAllowOther = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}

