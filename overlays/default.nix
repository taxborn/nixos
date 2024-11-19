{ inputs, ... }:

{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
      src = inputs.nixpkgs.legacyPackages."x86_64-linux".fetchgit {
        url = "https://github.com/taxborn/dwm";
        rev = "2d8deb3939655ee9bde0266b2aa0ea4af7aff9da";
        hash = "sha256-9aJdQnkuwzFL+fBZZp2+02YO7jT6C/Q7rurOxph5yz8=";
      };
    });
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
