{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.features.languages.zig;
in
{
  options.features.languages.zig.enable = mkEnableOption "enable support for zig";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.zig
      unstable.zls
    ];
  };
}
