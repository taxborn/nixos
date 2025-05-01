{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../common
    ./git.nix
    ./firefox.nix
  ];

  features = {
    cli.fish.enable = true;
    wm.hyprland.enable = true;
    terminal.ghostty.enable = true;
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
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    # files = [ ];
    allowOther = true;
  };

  home.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  programs.home-manager.enable = true;
}
