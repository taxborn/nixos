{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden
    bitwarden-cli
  ];

  home.persistence."/persist/home/taxborn" = {
    directories = [
      ".config/Bitwarden"
    ];
  };
}
