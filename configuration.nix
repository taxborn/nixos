# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;

    # This also enables dual-booting with Windows
    # TODO: Timezone issues
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Networking
  networking.hostName = "turing";
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
    packages = with pkgs; [
      fd
      google-chrome
      prismlauncher
      ripgrep
      spotify
      tmux

      unstable.alacritty
    ];
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
    arandr
    dmenu
    discord
    feh
    gcc
    gh
    jdk21
    llvmPackages_17.clang-unwrapped
    neofetch
    pavucontrol
    rustup
    st
    sqlite
    unzip
    vlc
    wget

    ntfs3g

    unstable.neovim
    # unstable.protonvpn-gui # eventually switch to OpenVPN config or wireshark (or wireguard?)
    # unstable.protonvpn-cli
    unstable.python312Full
    unstable.python312Packages.pip
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

