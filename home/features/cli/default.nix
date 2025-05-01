{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
  };

  programs.eza = {
    enable = true;
  };

  programs.bat.enable = true;
}
