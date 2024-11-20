{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.features.languages.c;
in
{
  options.features.languages.c.enable = mkEnableOption "enable support for c";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.clang
      unstable.clang-tools
      cmake
    ];
  };
}
