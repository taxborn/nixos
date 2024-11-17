{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    {
      dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
        src = inputs.nixpkgs.legacyPackages."x86_64-linux".fetchgit {
          url = "https://github.com/taxborn/dwm";
          rev = "c30c4814b3f242fdc76ee0c8f13996b087fd1b93";
          hash = "sha256-RMQuIcNni7kT3tOC4vNeKqluMWcv8na7UAJ0vaAwxn8=";
        };
      });
    };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
