{ pkgs, inputs, ... }:

{
  users.users.taxborn = {
    isNormalUser = true;
    # use mkpasswd to generate this
    hashedPassword = "$y$j9T$2VWEsqoOG56VDQHyZx9xt/$o856/HhLynVydq4FjogVtwtxlQKfvqomLC10xlCUeL1";
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamescope"
      "input"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMMMcjY+iw91OShWyaLeyVMxWBOEnrvu6a1nW27KIUXr taxborn@tungsten"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBJ+n5pimZv/vLfmME/UtuGTVLcc+Y2tInvd6H9vx9z taxborn@uranium"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYpjflr7vC6+Sz2u3YEzIq+zt0ZVYeJ2XAUKPk2kdT+ taxborn@plutonium"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
}
