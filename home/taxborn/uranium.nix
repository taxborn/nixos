{ config, pkgs, ... }: { 
  imports = [ 
    ./home.nix
    ../common
    ../features/cli
  ];

  features = {
    cli = {
      zsh.enable = true;
    };
  };

  # taxborn packages only on uranium
  home.packages = with pkgs; [
    alacritty
    google-chrome 
    dmenu
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs = {
    keychain = {
      enable = true;
      enableZshIntegration = true;
      agents = [ "ssh" "gpg" ];
      keys = [ "uranium" "9BC40CD3E8BA5EF2" ];
      extraFlags = [ "--nogui" "--quiet" ];
    };
  };
}
