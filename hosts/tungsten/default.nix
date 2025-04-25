{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.disko.nixosModules.default
      inputs.impermanence.nixosModules.impermanence
      inputs.home-manager.nixosModules.default

      ./hardware-configuration.nix
      ./disko.nix
      ./persist.nix
      ./boot.nix
    ];

  networking.hostName = "tungsten";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  users.users.taxborn = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$2VWEsqoOG56VDQHyZx9xt/$o856/HhLynVydq4FjogVtwtxlQKfvqomLC10xlCUeL1";
    extraGroups = [ "wheel" "networkmanager" "input" ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    fd
    ripgrep

    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans # or serif?
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;
  programs.hyprland.enable = true;
  programs.fuse.userAllowOther = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "taxborn" = import ../../home/taxborn;
    };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}

