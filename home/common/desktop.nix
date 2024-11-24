# desktop-exclusive user configuration
{ pkgs, ... }:

{
  features = {
    languages = {
      zig.enable = true;
      rust.enable = true;
      c.enable = true;
      javascript.enable = true;
    };
  };

  home.packages = with pkgs; [
    discord
    dmenu
    google-chrome
    xorg.xsetroot
    obsidian
    spotify

    # fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs = {
    alacritty.enable = true;
    vscode.enable = true;
  };
}
