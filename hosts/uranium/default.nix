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

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libvdpau
      vaapiVdpau
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      mesa # For RADV (recommended over AMDVLK)
    ];
  };

  home-manager = {
    users = { "taxborn" = import ../../home/uranium; };
    extraSpecialArgs = { hostname = "uranium"; };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
