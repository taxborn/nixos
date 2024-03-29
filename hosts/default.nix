{ config, lib, pkgs, inputs, ... }:

{
  # System-level imports
  imports = [
    ../modules/boot.nix
    ../modules/nixos.nix
    ../modules/xorg.nix
    ../modules/docker.nix
  ];

  # Set the default shell to Fish
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  networking.networkmanager.enable = true;
  # Disable the firewall altogether.
  networking.firewall.enable = false;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  users.users.taxborn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [ dmenu sqlite unzip wget ntfs3g ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "taxborn" ];
  };

  programs.steam.enable = true;

  # Enable GPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
    settings.default-cache-ttl = 4 * 60 * 60; # 4 hours
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Don't ever change.
}
