{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.default

    ../common
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "tungsten";
  programs.steam.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.hyprland.enable = true;
  programs.fuse.userAllowOther = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
