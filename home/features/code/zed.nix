{ config, lib, ... }:
with lib;
let
  cfg = config.features.code.zed;
in
{
  options.features.code.zed.enable = mkEnableOption "enable zed configuration";

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      installRemoteServer = true;
      extensions = [
        "nix"
        "catppuccin"
        "html"
        "toml"
        "dockerfile"
        "sql"
        "zig"
        "astro"
        "catppuccin-icons"
      ];
      userSettings = {
        icon_theme = "Catppuccin Mocha";
        theme = {
          mode = "dark";
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };

        features = {
          edit_prediction_provider = "zed";
        };
        vim_mode = true;
        ui_font_size = 15;
        ui_font_family = "Atkinson Hyperlegible Mono";
        buffer_font_family = "JetBransMonoNL Nerd Font Mono";
        buffer_font_size = 16;
        languages = {
          Nix = {
            language_servers = [
              "nil"
              "!nixd"
            ];
            formatter = {
              external = {
                command = "nixfmt";
              };
            };
          };
        };
      };
    };
    home.persistence."/persist/home/taxborn" = {
      directories = [ ".config/zed" ];
    };
  };
}
