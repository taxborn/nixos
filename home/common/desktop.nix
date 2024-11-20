# desktop-exclusive user configuration
{ pkgs, ... }:

{
  imports = [
    ../taxborn/home.nix
    ./default.nix
  ];

  features = {
    languages = {
      zig.enable = true;
      rust.enable = true;
      c.enable = true;
    };
  };

  home.packages = with pkgs; [
    dmenu
    google-chrome
    obsidian

    # fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs = {
    alacritty.enable = true;
    vscode.enable = true;
  };
}
