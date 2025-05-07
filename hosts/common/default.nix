{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./boot.nix
    ./persist.nix
    ./steam.nix
    ./security.nix
    ./fonts.nix

    ./users/taxborn.nix
  ];

  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # saves space
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  services.fstrim.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;

  programs.hyprland.enable = true;
  programs.fuse.userAllowOther = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      load = true;
      save = true;
      vi_mode = true;
    };
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim # TODO: move to home
    discord
    wget
    ntfs3g
    obs-studio
    efibootmgr

    spotify
    prismlauncher
    jdk21
  ];

  users.defaultUserShell = pkgs.fish;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };
  services.tailscale.enable = true;
}
