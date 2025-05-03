{ pkgs, ... }:

{
  # some nix-related packages that are useful
  environment.systemPackages = with pkgs; [ nixd nil nixfmt ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
