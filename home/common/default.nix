{
  config,
  lib,
  outputs,
  pkgs,
  ...
}:
let
  vscode-server = fetchTarball {
    url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
    sha256 = "09j4kvsxw1d5dvnhbsgih0icbrxqv90nzf0b589rb5z6gnzwjnqf";
  };
in
{
  imports = [
    "${vscode-server}/modules/vscode-server/home.nix"
    ../features/cli
    ../features/languages
  ];

  features = {
    cli = {
      zsh.enable = true;
      tmux.enable = true;
    };
  };

  # taxborn packages I want everywhere
  # home.packages = with pkgs; [ ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.unstable.neovim-unwrapped;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
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

  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services.vscode-server.enable = true;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  home.username = lib.mkDefault "taxborn";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "24.05";

}
