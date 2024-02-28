{ description = "Braxton's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, nixos-hardware, ... }@inputs:
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
	  # TODO: Are there any hardware presets I want to include for my desktop?
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
	  # Include nixos-hardware here because it's a Dell XPS 15 9520, we can
	  # load in some sensible defaults.
	  specialArgs = {inherit inputs unstable nixos-hardware;};
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
