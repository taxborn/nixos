{ pkgs, ... }:

{
  imports = [
    ../common/desktop.nix
    ../common
  ];

  # taxborn packages only on uranium
  # home.packages = with pkgs; [ ];

  home.file = {
    ".ssh/config" = {
      source = ../../dots/ssh/ssh_config-uranium;
      force = true;
    };

    ".xinitrc".text = ''
      #!/bin/bash

      # set the status bar
      while [ true ]; do
              xsetroot -name " `date -Is` "
              sleep 1
      done &

      # set the background
      bash ~/.fehbg
      # set the screen layout
      bash ~/.screenlayout/main.sh

      # start dwm
      exec dwm
    '';

    ".screenlayout/main.sh".text = ''
      #!/bin/sh
      xrandr --output DisplayPort-2 --off --output DisplayPort-3 --off --output DisplayPort-4 --mode 2560x1440 --rate 165 --pos 0x0 --rotate normal --output HDMI-A-4 --mode 1920x1080 --pos 2560x360 --rotate normal
    '';
  };

  # programs.borgmatic.backups = { };

  programs.keychain.keys = [
    "uranium"
    "9BC40CD3E8BA5EF2"
  ];
}
