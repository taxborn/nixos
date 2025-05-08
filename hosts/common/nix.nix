{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  # some nix-related packages that are useful
  environment.systemPackages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style
  ];

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld-rs;

  nix = {
    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: { flake = v; }) inputs;

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    settings.warn-dirty = false;
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
