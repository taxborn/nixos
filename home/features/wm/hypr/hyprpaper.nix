{ pkgs, ... }:

let
  wallpaper = "~/Pictures/Wallpapers/abstract-swirls.jpg";
in
{
  home.packages = [ pkgs.hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = ,${wallpaper}
  '';
}
