{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, ... }@inputs:
    let
      overlay = final: prev: let
	unstablePkgs = import unstable { inherit (prev) system; config.allowUnfree = true; };
      in {
	unstable = unstablePkgs;
      };
      overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
	turing = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs unstable;};
	  modules = [ 
	    overlayModule
	    ./hosts/turing/configuration.nix
	    inputs.home-manager.nixosModules.home-manager {
	      home-manager.users = {
		taxborn = import ./home-manager/home.nix;
	      };
	    }
	  ];
	};

	euclid = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs unstable;};
	  modules = [ 
	    overlayModule
	    ./hosts/euclid/configuration.nix
	    inputs.home-manager.nixosModules.home-manager {
	      home-manager.users = {
		taxborn = import ./home-manager/home.nix;
	      };
	    }
	  ];
	};
      };
    };
}
