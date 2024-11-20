# Global CLI configuration
{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./tmux.nix
    # TODO: is this the proper place to import this?
    ../languages/c.nix
  ];

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraOptions = [
        "-l"
        "--icons"
        "--git"
        "-a"
      ];
    };

    # TODO: configure
    bat.enable = true;

    feh.enable = true;

    ranger = {
      enable = true;
      settings.line_numbers = "relative";
    };
  };

  home.packages = with pkgs; [
    coreutils # needed?
    fd
    fzf
    htop
    jq
    ripgrep
    tldr
	unzip
    xsel
    zip
  ];
}
