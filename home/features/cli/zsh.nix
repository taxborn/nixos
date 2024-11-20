{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.features.cli.zsh;
in
{
  options.features.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fzf-zsh
    ];

    programs.zsh = {
      enable = true;
      shellAliases = {
        ls = "eza";
        grep = "rg";
        ps = "procs";
        rb = "sudo nixos-rebuild switch --flake ~/dev/projects/nixos";
      };
      oh-my-zsh = {
        enable = true;
        theme = "lukerandall";
      };
    };
  };
}
