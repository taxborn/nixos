{ inputs, ... }:

{
  users.users.taxborn = {
    isNormalUser = true;
    # use mkpasswd to generate this
    hashedPassword = "$y$j9T$2VWEsqoOG56VDQHyZx9xt/$o856/HhLynVydq4FjogVtwtxlQKfvqomLC10xlCUeL1";
    extraGroups = [ "wheel" "networkmanager" "input" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "taxborn" = import ../../../home/taxborn;
    };
  };
}
