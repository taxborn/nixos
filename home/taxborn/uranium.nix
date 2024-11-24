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

      # start dwm
      exec dwm
    '';
  };

  # programs.borgmatic.backups = { };

  programs.keychain.keys = [
    "uranium"
    "9BC40CD3E8BA5EF2"
  ];
}
