{
  description = ''
    taxborn's nixos configuration
    read the project readme for more info
  '';

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, home-manager, nixpkgs, nixos-hardware, ... } @ inputs:
    let
      inherit (self) outputs;
      # TODO: evaluate which systems I need
      systems = [
        "x86_64-linux"
        # "x86_64-darwin"
        # "i686-linux"
        # "aarch64-linux"
        # "aarch64-darwin"
        # "armv6l-linux"
        # "armv7l-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        uranium = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/uranium ];
        };

        tungsten = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ 
            ./hosts/tungsten 
            nixos-hardware.nixosModules.dell-xps-15-9520
          ];
        };

        helium-01 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/helium-01 ];
        };

        helium-02 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/helium-02 ];
        };
      };

      homeConfigurations = {
        "taxborn@uranium" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/taxborn/uranium.nix ];
        };

        "taxborn@tungsten" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/taxborn/tungsten.nix ];
        };

        "taxborn@helium-01" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/taxborn/helium.nix ];
        };

        "taxborn@helium-02" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/taxborn/helium.nix ];
        };
      };
    };
}
