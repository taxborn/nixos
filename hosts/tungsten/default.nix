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

  home-manager = {
    users = { "taxborn" = import ../../home/tungsten; };
    extraSpecialArgs = { hostname = "tungsten"; };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
