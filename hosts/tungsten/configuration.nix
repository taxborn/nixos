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

  # Enable touchpad support
  services.libinput.enable = true;

  # tungsten-exclusive system packages
  # environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "24.05"; # Don't update
}
