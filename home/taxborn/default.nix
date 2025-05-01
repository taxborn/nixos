{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../common
    ../features/cli
    ../features/wm/hypr
    ./git.nix
    ./firefox.nix
  ];


  home.persistence."/persist/home/taxborn" = {
    directories = [
      "Downloads"
      "Dev"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".local/share/zed"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    # files = [ ];
    allowOther = true;
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.home-manager.enable = true;
}
