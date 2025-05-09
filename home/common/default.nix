{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ./git.nix
    ./firefox.nix
    ./gpg.nix
    ./bitwarden.nix

    ../features/cli
    ../features/languages
    ../features/wm
    ../features/terminal/ghostty.nix
    ../features/code
  ];

  home.packages = with pkgs; [
    obsidian
  ];

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };

  programs = {
    command-not-found.enable = true;
  };

  features = {
    cli.fish.enable = true;
    wm.hyprland.enable = true;
    terminal.ghostty.enable = true;
    code.zed.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "ghostty";
  };

  home.persistence."/persist/home/taxborn" = {
    directories = [
      "Downloads"
      "Dev"
      "Games"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".local/share/zed"
      ".config/obsidian"
      ".pki"
      ".cache/spotify"
      ".config/spotify"
      ".config/discord"
      ".local/share/PrismLauncher"
      {
        directory = ".local/share/vulkan";
        method = "symlink";
      }
      {
        directory = ".local/share/hyprland";
        method = "symlink";
      }
      {
        directory = ".cache/mesa_shader_cache_db";
        method = "symlink";
      }
      {
        directory = ".cache/radv_builtin_shaders";
        method = "symlink";
      }
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        method = "symlink";
        directory = ".steam";
      }
    ];
    # files = [ ];
    allowOther = true;
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
