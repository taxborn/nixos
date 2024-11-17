{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.taxborn = {
    isNormalUser = true;
    description = "Braxton Fair";
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];

    initialHashedPassword = "$y$j9T$sfTsI6QwCtxiJbDQP2XnY/$L.bFrSjEG/Hj3lTz7JZv6by/iYH.b87FaV.FIwfj1K6";
    # for uranium, we only want tungsten to be allowed in.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvlhtxQLO5zhlTcztBMOpkL+xSGWVWd/dTEu+Jb4zsM taxborn@tungsten (hello@taxborn.com)"
    ];
  };

  home-manager.users.taxborn = import taxborn/${config.networking.hostName}.nix;
}
