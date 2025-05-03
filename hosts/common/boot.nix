{
  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      consoleMode = "max";
      configurationLimit = 10;
    };
  };

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=auto"
    "udev.log_level=3"
  ];
}
