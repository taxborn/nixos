{
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/tailscale"
      "/var/db/sudo/lectured" # save who had the `sudo` prompt
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [ "/etc/machine-id" ];
  };
  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root -"
    "d /persist/home/taxborn 0700 taxborn users -"
  ];
}
