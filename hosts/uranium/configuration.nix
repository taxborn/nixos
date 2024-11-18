{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "uranium";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
  };

  # enable amd gpu
  hardware.opengl.driSupport32Bit = true; # For 32 bit applications, deprecated
  # hardware.graphics.enable32Bit = true; # For 32 bit applications, updated way

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
    rocmPackages.clr.icd
  ];

  # For 32 bit applications 
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  hardware.pulseaudio.enable = true;
  # TODO: pipewire
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # uranium-exclusive system packages
  environment.systemPackages = with pkgs; [
    clinfo
  ];

  programs.zsh.enable = true;

  system.stateVersion = "24.05"; # Don't update
}

