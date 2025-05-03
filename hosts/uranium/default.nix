{
  inputs,
  ...
}:

{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.default

    ../common
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "uranium";

  home-manager = {
    users = {
      "taxborn" = import ../../home/uranium;
    };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
