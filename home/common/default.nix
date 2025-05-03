{ inputs, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ./git.nix
    ./firefox.nix

    ../features/cli
    ../features/wm
    ../features/terminal/ghostty.nix
    ../features/code
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    atkinson-hyperlegible-next
    obsidian
  ];

  programs = { command-not-found.enable = true; };

  features = {
    cli.fish.enable = true;
    wm.hyprland.enable = true;
    terminal.ghostty.enable = true;
    code.zed.enable = true;
  };

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
      ".config/obsidian"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    # files = [ ];
    allowOther = true;
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
