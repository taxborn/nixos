{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.features.languages.rust;
in
{
  options.features.languages.rust.enable = mkEnableOption "enable support for rust";

  config = mkIf cfg.enable { home.packages = with pkgs; [ rustup ]; };
}
