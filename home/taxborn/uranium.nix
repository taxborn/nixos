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
    obsidian
    dmenu
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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
  };
}
