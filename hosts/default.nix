{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../modules
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
    arandr
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

  programs.fish.enable = true;

  # Alias `rebuild` to rebuild the os
  environment.interactiveShellInit = ''
    alias rebuild="sudo nixos-rebuild switch --flake /home/taxborn/dev/code/nixos/#$(hostname)"
    alias dl-repos="gh repo list taxborn --source --json nameWithOwner -q \".[].nameWithOwner\" | xargs -L1 gh repo clone"
    alias vim="nvim"
    alias vi="nvim"
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
    settings.default-cache-ttl = 4 * 60 * 60; # 4 hours
  };

  programs.steam.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Don't ever change.
}
