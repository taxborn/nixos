{ config, lib, pkgs, inputs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  # X11 configuration
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps; # Ensure i3 is i3-gaps
    };

    windowManager.dwm.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    xkb.layout = "us";
    # xkb.options = "eurosign:e,caps:escape";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
      unstable.alacritty
      fd
      google-chrome
      prismlauncher
      ripgrep
      spotify
      tmux
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
    dmenu
    discord
    feh
    gcc
    gh
    git
    # gnome.gnome-keyring # might be needed for protonvpn again
    jdk21
    llvmPackages_17.clang-unwrapped
    neofetch
    pavucontrol
    rustup
    st
    unzip
    vlc
    wget

    unstable.neovim
    # unstable.protonvpn-gui # eventually switch to OpenVPN config or wireshark (or wireguard?)
    # unstable.protonvpn-cli
    unstable.python312Full
    unstable.python312Packages.pip
  ];

  # Alias `rebuild` to rebuild the os
  environment.interactiveShellInit = ''
    alias rebuild="sudo nixos-rebuild switch --flake /home/taxborn/dev/code/nixos/#$(hostname)"
    alias dl-repos="gh repo list taxborn --source --json nameWithOwner -q \".[].nameWithOwner\" | xargs -L1 gh repo clone"
  '';

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "taxborn" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
  };

  programs.steam.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Don't ever change.
}
