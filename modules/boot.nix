{ config, ... }:

{
  # Use the GRUB bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;

    # This also enables dual-booting with Windows
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # ensure time between Windows and NixOS is synced
  time.hardwareClockInLocalTime = true;
}
