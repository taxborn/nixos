{
  description = "Braxton's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager, nixos-hardware, ... }:
    let
      # Allow the 'unstable' prefix for packages.
      overlay = final: prev:
        let
          unstablePkgs = import unstable {
            inherit (prev) system;
            config.allowUnfree = true;
          };
        in { unstable = unstablePkgs; };

      overlayModule =
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

      nixosConfigurations = {
        # Desktop configuration
        turing = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit unstable; };
          modules = [ overlayModule ./hosts/turing/configuration.nix ];
        };
        # Laptop configuration
        euclid = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit unstable nixos-hardware; };
          modules = [ overlayModule ./hosts/euclid/configuration.nix ];
        };
      };

      # User configuration
      homeConfigurations = {
        taxborn = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = { inherit unstable; };
          modules = [ overlayModule ./home.nix ];
        };
      };
    };
}
