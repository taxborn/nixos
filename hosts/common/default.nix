{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./boot.nix
    ./persist.nix

    ./users/taxborn.nix
  ];

  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    neovim
    tmux
    wget
    fd
    ripgrep

    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans # or serif?
  ];

  users.defaultUserShell = pkgs.fish;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;
}
