{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.features.terminal.ghostty;
in
{
  options.features.terminal.ghostty.enable = mkEnableOption "enable ghostty configuration";

  config = mkIf cfg.enable {
    programs.ghostty.enable = true;

    home.persistence."/persist/home/taxborn" = {
      directories = [ ".config/ghostty" ];
    };
  };
}
