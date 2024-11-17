{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "uranium";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  hardware.pulseaudio.enable = true;
  # TODO: pipewire
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # uranium-exclusive system packages
  # environment.systemPackages = with pkgs; [ ];

  programs.zsh.enable = true;

  system.stateVersion = "24.05"; # Don't update
}

