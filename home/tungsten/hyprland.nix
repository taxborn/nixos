{ pkgs, ... }: {
{
  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-1,3456x2160@60,auto,1.6" ];
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 48; # Bigger cursor for 4K
  };
}
