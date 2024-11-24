{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.features.languages.javascript;
in
{
  options.features.languages.javascript.enable = mkEnableOption "enable support for javascript";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs_22
    ];
  };
}
