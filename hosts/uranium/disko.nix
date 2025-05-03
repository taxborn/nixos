{
  fileSystems."/persist".neededForBoot = true;

  fileSystems."/mnt/windows" = {
    device =
      "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X900698K_1-part3";
    fsType = "ntfs-3g";
    options = [ "uid=1000" "gid=1000" "umask=0022" ];
  };

  boot.loader.systemd-boot.windows = {
    "11" = {
      title = "Windows 11";
      efiDeviceHandle = "FS1";
      sortKey = "z_windows"; # does this put it in front?
    };
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S76ENL0X900787H";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/secret.key";
                settings = { allowDiscards = true; };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-L" "nixos" "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions =
                        [ "compress=zstd" "subvol=root" "noatime" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "subvol=nix" "noatime" ];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions =
                        [ "compress=zstd" "subvol=persist" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
