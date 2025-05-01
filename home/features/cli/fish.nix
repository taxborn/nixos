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
      '';
      shellAbbrs = {
        "rb" = "sudo nixos-rebuild switch --flake ~/Dev/Projects/nixos-configuration";
        "what-changed" =
          "sudo fd --one-file-system --base-directory / --type f --hidden --exclude \"{tmp,etc/passwd}\"";
        "ls" = "eza";
        "grep" = "rg";
        "ps" = "procs";
      };
    };
  };
}
