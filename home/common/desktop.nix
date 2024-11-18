# desktop-exclusive user configuration
{ pkgs, ... }:

{
  imports = [
    ../taxborn/home.nix
    ./default.nix
    ../features/cli
  ];

  features = {
    cli = {
      zsh.enable = true;
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
