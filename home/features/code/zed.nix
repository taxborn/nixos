{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.features.code.zed;
in
{
  options.features.code.zed.enable = mkEnableOption "enable zed configuration";

  config = mkIf cfg.enable {
    programs.zed-editor.enable = true;
    home.persistence."/persist/home/taxborn" = {
      directories = [ ".config/zed" ];
    };
  };
}
