/*
  Uranium configuration. This is my desktop PC.

  CPU: Intel i7-13700K
  GPU: XFX Speedster MERC310 AMD RX 7900 XT
*/
{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "uranium";

  # drivers and changes for the 7900 XT
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  hardware.graphics = {
    enable32Bit = true; # For 32 bit applications

    extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr.icd
    ];
    # For 32 bit applications
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  # uranium-exclusive system packages
  environment.systemPackages = with pkgs; [ clinfo ];

  system.stateVersion = "24.05"; # Don't update
}
