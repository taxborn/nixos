{ config, lib, pkgs, ... }:

{
  # TODO: nixos-hardware
  imports =
    [
      ./hardware-configuration.nix
    ];
  
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      crypthome UUID=63ee1220-800d-43be-9694-c0c89a1fc63c /root/home.key
    '';
  };

  networking.hostName = "tungsten";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = true;
  # TODO: pipewire
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # tungsten-exclusive system packages
  # environment.systemPackages = with pkgs; [ ];

  programs.zsh.enable = true;

  system.stateVersion = "24.05"; # Don't update
}

