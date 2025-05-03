{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.features.cli.fish;
in
{
  options.features.cli.fish.enable = mkEnableOption "enable extended fish configuration";

  config = mkIf cfg.enable {
    home.persistence."/persist/home/taxborn" = {
      directories = [
        ".cache/fish"
      ];
    };
    programs.fish = {
      enable = true;
      loginShellInit = ''
        set -x NIX_PATH nixpkgs=channel:nixos-unstable
        set -x NIX_LOG info
        set -x TERMINAL ghostty
        set -x EDITOR nvim
        set -x FISH_GREETING

        if test (tty) = "/dev/tty1"
          exec Hyprland &> /dev/null
        end

        bind ctrl-o 'yazi'
      '';
      shellAbbrs = {
        "rb" = "sudo nixos-rebuild switch --flake ~/Dev/Projects/nixos-configuration";
        "impermanence" =
          "sudo fd --one-file-system --base-directory / --type f --hidden --exclude \"{tmp,etc/passwd}\"";
        "ls" = "eza";
        "grep" = "rg";
        "ps" = "procs";
      };
    };
  };
}
