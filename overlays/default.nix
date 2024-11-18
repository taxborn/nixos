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
          rev = "b0b5d3c85801d86d9ef29873a86c475fd8f4a41e";
          hash = "sha256-YQ/eGR45xHISO3E7/ElOUnmHQ7INylS9VAll6fdUSxQ=";
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
