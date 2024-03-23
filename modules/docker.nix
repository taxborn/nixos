{ config, lib, ... }:

{
  virtualisation.docker.enable = true;
  users.users.taxborn.extraGroups = [ "docker" ];
}
