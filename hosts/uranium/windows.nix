{
  # Mount the windows partition, idk if this will ever be useful but why not
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X900698K_1-part3";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=1000"
      "umask=0022"
    ];
  };

  boot.loader.systemd-boot.windows = {
    "11" = {
      title = "Windows 11";
      efiDeviceHandle = "FS1";
      sortKey = "z_windows";
    };
  };
}
