{ pkgs, inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.default

    ../common
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "uranium";

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  home-manager = {
    users = {
      "taxborn" = import ../../home/uranium;
    };
    extraSpecialArgs = {
      hostname = "uranium";
    };
  };

  system.stateVersion = "24.11";
}
