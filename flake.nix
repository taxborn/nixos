{
  description = "taxborn's nixos flake";

  inputs = {
    # I want my system to typically track unstable, as a sort-of rolling-release schedule of updates.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Install things as stable when possible :)
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Useful for laptop and other device defaults
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, } @ inputs: let
    inherit (self) outputs; # TODO: wtf does this do
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    # not sure if this is the correct way to go
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    inherit lib;

    nixosConfigurations = {
      uranium = lib.nixosSystem {
        modules = [ ./hosts/uranium ];
        specialArgs = { inherit inputs outputs; };
      };
      tungsten = lib.nixosSystem {
        modules = [ ./hosts/tungsten ];
        specialArgs = { inherit inputs outputs; };
      };
      helium = lib.nixosSystem {
        modules = [ ./hosts/helium ];
        specialArgs = { inherit inputs outputs; };
      };
    };

    homeConfigurations = {
      "taxborn" = lib.homeManagerConfiguration {
        modules = [ ./home/taxborn ];
        pkgs = pkgs.${system}; # also pkgs.x86_64-linux
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
