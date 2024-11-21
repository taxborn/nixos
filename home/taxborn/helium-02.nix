{ pkgs, ... }:

{
  imports = [
    ../common/server.nix
    ../common
  ];

  # taxborn packages only on helium-02
  # home.packages = with pkgs; [ ];

  programs.keychain.keys = [
    "helium"
    "9BC40CD3E8BA5EF2"
  ];
}
