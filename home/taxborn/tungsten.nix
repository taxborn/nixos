{ pkgs, ... }:

{
  imports = [
    ../common/desktop.nix
    ../common
  ];

  # taxborn packages only on uranium
  home.packages = with pkgs; [ brightnessctl ];

  home.file = {
    ".ssh/config" = {
      source = ../../dots/ssh/ssh_config-tungsten;
      force = true;
    };
    ".Xresources".text = ''
      Xft.dpi: 192
    '';
    ".xinitrc".text = ''
      #!/bin/bash

      # set the status bar
      while [ true ]; do
              xsetroot -name " `cat /sys/class/power_supply/BAT0/capacity`% `date -Is` "
              sleep 1
      done &

      # set the background
      bash ~/.fehbg

      xrdb -merge ~/.Xresources

      # start dwm
      exec dwm
    '';
  };

  programs.keychain.keys = [
    "tungsten"
    "9BC40CD3E8BA5EF2"
  ];
}
