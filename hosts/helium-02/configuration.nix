{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "helium-02"; # Define your hostname.

  # helium-02-exclusive system packages (not recommended)
  # environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
