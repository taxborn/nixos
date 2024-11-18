# Global CLI configuration
{ pkgs, ... }:

{
  imports = [ ./zsh.nix ./tmux.nix ];

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraOptions = [ "-l" "--icons" "--git" "-a" ];
    };

    # TODO: configure
    bat.enable = true;

    ranger = {
      enable = true;
      settings = {
        line_numbers = "relative";
      };
    };
  };

  home.packages = with pkgs; [
    coreutils # needed?
    fd
    htop
    jq
    ripgrep
    tldr
    zip
  ];
}
