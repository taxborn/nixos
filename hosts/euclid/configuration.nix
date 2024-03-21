# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, nixos-hardware, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../default.nix
      # NixOS hardware configurations
      nixos-hardware.nixosModules.dell-xps-15-9520-nvidia
      nixos-hardware.nixosModules.common-hidpi
    ];

  networking.hostName = "euclid";

  services.xserver = {
    # TODO: why is the mouse so god damn tiny
    dpi = 180; # 261 is the 'actual' dpi, but I find this value to be better

    libinput = {
      touchpad.tapping = false;
      touchpad.disableWhileTyping = true;
      touchpad.scrollMethod = "twofinger";
      touchpad.naturalScrolling = false;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = null; # will be managed by tlp

  services.dbus.enable = true;
  services.acpid.enable = true;
  services.upower.enable = true;
  services.tlp.enable = true;}
}
