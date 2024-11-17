{
  config,
  lib,
  ...
}: with lib; let
  cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      # TODO: are these next two needed with keychain?
      initExtra = ''
        eval $(ssh-agent -s) > /dev/null
      '';
      envExtra = ''
	export GPG_TTY=$(tty)
      '';
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
