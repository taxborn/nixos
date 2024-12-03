# desktop-exclusive system configuration
{ ... }:

{
  # sound
  hardware.pulseaudio.enable = true;
  # TODO: pipewire
  services.pipewire = {
   enable = false;
   pulse.enable = false;
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # spotify related (https://nixos.wiki/wiki/Spotify#Local_discovery)
  networking.firewall.allowedTCPPorts = [ 57621 ]; # sync local tracks
  networking.firewall.allowedUDPPorts = [ 5353 ]; # discovery spotify connect devices

  # xserver
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
  };
}
