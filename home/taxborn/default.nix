{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./hyprland.nix
    ./git.nix
  ];

  home.stateVersion = "24.11";

  home.persistence."/persist/home/taxborn" = {
    directories = [
      ".mozilla/firefox"
      ".cache/mozilla/firefox"
      "Downloads"
      "Dev"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
    ];
    # files = [ ];
    allowOther = true;
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs = {
    home-manager.enable = true; # allow home-manager to manage itself?
    firefox.enable = true;
  };
}
