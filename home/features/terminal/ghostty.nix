{ pkgs, ... }:

{
  programs.ghostty.enable = true;
  home.persistence."/persist/home/taxborn" = {
    directories = [ ".config/ghostty" ];
  };
}
