{ config, lib, pkgs, inputs, ... }:

{
  # System-level imports
  imports = [
    ../modules/boot.nix
  ];

  # Set the default shell to Fish
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  networking.networkmanager.enable = true;
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

    # allow unfree packages, eventually move this to the idea per-package setup
  nixpkgs.config.allowUnfree = true;

  nix = {
    # nix flakes :)
    settings.experimental-features = [ "nix-command" "flakes" ];

    # have nix garbage collect every week
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # X11 configuration
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # i3
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps; # Ensure i3 is i3-gaps
    };

    windowManager.dwm = {
      enable = true;
      # url = ...; # a local version of dwm
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    xkb.layout = "us";
    # xkb.options = "eurosign:e,caps:escape";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      # defaultSession = "none+dwm";
    };
  };

  environment.systemPackages = with pkgs; [
    dmenu
    sqlite
    unzip
    wget
    ntfs3g
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "taxborn" ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
    settings.default-cache-ttl = 4 * 60 * 60; # 4 hours
  };

  programs.steam.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Don't ever change.
}
