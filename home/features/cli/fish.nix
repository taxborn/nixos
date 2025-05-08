{ config, lib, ... }:
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
        ".config/fish"
      ];
      files = [
        ".local/share/fish/fish_history"
      ];
    };
    programs.fish = {
      enable = true;
      loginShellInit = ''
        set -x NIX_PATH nixpkgs=channel:nixos-unstable
        set -x NIX_LOG info
        set -x TERMINAL ghostty
        set -x EDITOR nvim
        set fish_greeting

        bind ctrl-o 'yazi'
      '';
      shellAbbrs = {
        "rb" = "sudo nixos-rebuild switch --flake ~/Dev/Projects/nixos-configuration";
        "impermanence" =
          ''sudo fd --one-file-system --base-directory / --type f --hidden --exclude "{tmp,etc/passwd,home/taxborn/.cache/nix}"'';
        "ls" = "eza";
        "grep" = "rg";
        "ps" = "procs";
      };
    };
  };
}
