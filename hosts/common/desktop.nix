# desktop-exclusive system configuration
{ ... }:

{
  # sound
  hardware.pulseaudio.enable = true;
  # TODO: pipewire
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # xserver
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
  };
}
