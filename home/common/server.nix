# server-exclusive user configuration
{
  imports = [
    ../taxborn/home.nix
    ./default.nix
    ../features/cli
  ];

  features = {
    cli = {
      zsh.enable = true;
    };
  };
}
