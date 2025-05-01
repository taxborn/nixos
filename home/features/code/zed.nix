{ pkgs, ... }:

{
  programs.zed-editor.enable = true;
  home.persistence."/persist/home/taxborn" = {
    directories = [ ".config/zed" ];
  };
}
