/*
Tungsten, my Dell XPS 15 9520

CPU: Intel i9-12900HK
GPU: GeForce RTX 3050 Ti
*/
{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "tungsten";

  # since the home partition is unlocked with a seperate key, we need to edit the `/etc/crypttab` to let LUKS know to unlock it.
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      crypthome UUID=63ee1220-800d-43be-9694-c0c89a1fc63c /root/home.key
    '';
  };
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/c3f55e53-8168-4d39-a56b-a9a2d1fed129";

  # Enable touchpad support
  services.libinput.enable = true;

  # tungsten-exclusive system packages
  # environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "24.05"; # Don't update
}
