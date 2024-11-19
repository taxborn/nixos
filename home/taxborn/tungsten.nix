{ pkgs, ... }:

{
  imports = [ ../common/desktop.nix ];

  # taxborn packages only on uranium
  home.packages = with pkgs; [ brightnessctl ];

  home.file = {
    ".ssh/config" = {
      source = ../../dots/ssh/ssh_config-tungsten;
      force = true;
    };
  };

  programs.keychain.keys = [
    "tungsten"
    "9BC40CD3E8BA5EF2"
  ];
}
