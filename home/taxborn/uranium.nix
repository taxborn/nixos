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
    dmenu
    google-chrome 
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    obsidian
  ];

  home.file = {
    ".ssh/config" = {
      source = ../../dots/ssh_config-uranium;
      force = true;
    };
  };

  programs = {
    keychain = {
      enable = true;
      enableZshIntegration = true;
      agents = [ "ssh" "gpg" ];
      keys = [ "uranium" "9BC40CD3E8BA5EF2" ];
      extraFlags = [ "--nogui" "--quiet" ];
    };

    vscode = {
      enable = true;
    };
  };
}
