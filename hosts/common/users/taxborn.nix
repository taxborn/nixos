{
  config,
  pkgs,
  inputs,
  ...
}:

{
  users.users.taxborn = {
    isNormalUser = true;
    description = "Braxton Fair";
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "docker"
    ];

    initialHashedPassword = "$y$j9T$sfTsI6QwCtxiJbDQP2XnY/$L.bFrSjEG/Hj3lTz7JZv6by/iYH.b87FaV.FIwfj1K6";
    # we want tungsten and uranium to be able to ssh into devices
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvlhtxQLO5zhlTcztBMOpkL+xSGWVWd/dTEu+Jb4zsM taxborn@tungsten (hello@taxborn.com)"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDex5NmMiZqlhAaXQb7XFS8LlwVtWm7r6lMVgoD2Gn66 taxborn@uranium (hello@taxborn.com)"
    ];
  };

  home-manager.users.taxborn = import taxborn/${config.networking.hostName}.nix;
}
