{ config, lib, ... }:

{
  # allow unfree packages, eventually move this to the idea per-package setup
  nixpkgs.config.allowUnfree = true;

  nix = {
    # nix flakes :)
    settings.experimental-features = [ "nix-command" "flakes" ];

    # have nix garbage collect every week
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
