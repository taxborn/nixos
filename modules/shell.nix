{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/taxborn/dev/code/nixos/ && home-manager switch --flake /home/taxborn/dev/code/nixos/";
      dl-repos = "gh repo list taxborn --source --json nameWithOwner -q \".[].nameWithOwner\" | xargs -L1 gh repo clone";
      vim="nvim";
      vi="nvim";
    };
  };
}
