{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./boot.nix
    ./persist.nix
    ./security.nix

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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;

    extraPackages = with pkgs; [
      gamescope
      xwayland-run
    ];
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.steam.package =
    let
      x-wrapped =
        steam:
        pkgs.runCommand "x-run-steam" { inherit (steam) passthru meta; } ''
          cp -r ${steam} $out

          # $out/share is a symlink to ${steam}/share
          # but since we need to edit its internals, we need to expand it to a real directory
          # that can be edited

          # first we need to make sure we can remove it
          chmod -R +w $out

          # then remove, recreate, and populate it
          rm $out/share
          mkdir $out/share
          cp -r ${steam}/share/* $out/share/

          # and of course, make sure we can edit the desktop file again
          chmod -R +w $out

          sed -i 's/Exec=steam/Exec=x-run steam/g' $out/share/applications/steam.desktop
        '';
    in
    x-wrapped pkgs.steam
    // {
      override = f: x-wrapped (pkgs.steam.override f);
    };

  programs.gamemode.enable = true;

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
    tmux # TODO: move to home
    discord
    wget
    ntfs3g
    efibootmgr
    fd
    ripgrep

    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans # or serif?

    spotify
    prismlauncher
    jdk21
  ];

  users.defaultUserShell = pkgs.fish;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;
}
