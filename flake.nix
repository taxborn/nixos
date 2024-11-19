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

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      nixos-hardware,
      vscode-server,
      ...
    }@inputs:
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
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosConfigurations = {
        uranium = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            vscode-server.nixosModules.default
            ./hosts/uranium
          ];
        };

        tungsten = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            vscode-server.nixosModules.default
            nixos-hardware.nixosModules.dell-xps-15-9520
            ./hosts/tungsten
          ];
        };

        helium-01 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            vscode-server.nixosModules.default
            ./hosts/helium-01
          ];
        };

        helium-02 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/helium-02
            vscode-server.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "taxborn@uranium" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/taxborn/uranium.nix ];
        };

        "taxborn@tungsten" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/taxborn/tungsten.nix ];
        };

        "taxborn@helium-01" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/taxborn/helium.nix ];
        };

        "taxborn@helium-02" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/taxborn/helium.nix ];
        };
      };
    };
}
