# Global CLI configuration
{ pkgs, ... }:

{
  imports = [ ./zsh.nix ];

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraOptions = [ "-l" "--git" "-a" ]; # TODO: "--icons" when nerd font installed
    };

    # TODO: configure
    bat.enable = true;

    ranger = {
      enable = true;
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
