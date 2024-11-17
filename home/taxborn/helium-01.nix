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

  # taxborn packages only on the nucs
  home.packages = with pkgs; [
    cowsay
  ];

  programs = {
    keychain = {
      enable = true;
      enableZshIntegration = true;
      agents = [ "ssh" "gpg" ];
      keys = [ "helium" "9BC40CD3E8BA5EF2" ];
      extraFlags = [ "--nogui" "--quiet" ];
    };
  };
}
