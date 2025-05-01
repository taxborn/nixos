{ pkgs, ... }:

{
  imports = [
    ../features/cli
    ../features/wm
    ../features/terminal/ghostty.nix
    ../features/code
  ];

  home.stateVersion = "24.11";

  home.packages = with pkgs; [ cowsay ];
}
