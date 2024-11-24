{ pkgs, ... }:

{
  networking.hostName = "helium-01"; # Define your hostname.
  boot.supportedFilesystems = [ "ntfs" ];

  # helium-01-exclusive system packages (not recommended)
  # environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
