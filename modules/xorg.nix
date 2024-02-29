{ config, pkgs, ... }:

{
  # X11 configuration
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # i3
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps; # Ensure i3 is i3-gaps
    };

    windowManager.dwm = {
      enable = true;
      # url = ...; # a local version of dwm
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    xkb.layout = "us";
    # xkb.options = "eurosign:e,caps:escape";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      # defaultSession = "none+dwm";
    };
  };
}
