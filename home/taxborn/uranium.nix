{ pkgs, ... }:

{
  imports = [ ../common/desktop.nix ];

  # taxborn packages only on uranium
  # home.packages = with pkgs; [ ];

  home.file = {
    ".ssh/config" = {
      source = ../../dots/ssh/ssh_config-uranium;
      force = true;
    };
  };

  programs.keychain.keys = [
    "uranium"
    "9BC40CD3E8BA5EF2"
  ];
}
