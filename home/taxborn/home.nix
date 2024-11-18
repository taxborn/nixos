{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.username = lib.mkDefault "taxborn";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "24.05";

  # taxborn packages I want everywhere
  # home.packages = with pkgs; [ ];

  # If you are looking for my dotfiles, most are at https://github.com/taxborn/dotfiles
  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
    };

    git = {
      enable = true;
      userEmail = "hello@taxborn.com";
      userName = "Braxton Fair";
      signing = {
        key = "9BC40CD3E8BA5EF2";
        signByDefault = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    keychain = {
      enable = true;
      enableZshIntegration = true;
      agents = [
        "ssh"
        "gpg"
      ];
      extraFlags = [
        "--nogui"
        "--quiet"
      ];
    };

    home-manager.enable = true;
  };
}
