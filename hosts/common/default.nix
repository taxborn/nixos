# Common configuration for all hosts
{
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}:

{
  imports = [
    ./users
    inputs.home-manager.nixosModules.home-manager
  ];

  # bootloader config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # packages I want installed on ALL systems
  environment.systemPackages = with pkgs; [ wget ];

  users.defaultUserShell = pkgs.zsh;

  programs.gnupg.agent = {
    pinentryPackage = pkgs.pinentry-tty;
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
    settings.UsePAM = true;
  };

  services.vscode-server.enable = true;

  # nix
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "taxborn"
      ]; # Set users that are allowed to use the flake command
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
      (lib.filterAttrs (_: lib.isType "flake")) inputs
    );
    # TODO: what is this
    # nixPath = [ "/etc/nix/path" ];
  };

  # home manager
  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };
}
