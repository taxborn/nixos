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

  # xserver
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
  };
}
