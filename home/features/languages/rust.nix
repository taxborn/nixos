{
  config,
  lib,
  pkgs,
  ...
}:
let
  toml = pkgs.formats.toml { };
in
{
  home.file."${config.xdg.dataHome}/cargo/config.toml".source = toml.generate "config.toml" {
    linker = lib.getExe pkgs.clang;
    rustflags = [
      "-C"
      # Use mold instead of the default linker
      "link-arg=-fuse-ld=${lib.getExe pkgs.mold}"
    ];
  };

  home.packages = with pkgs; [
    rust-analyzer-unwrapped

    cargo-sort
    cargo-bloat
    cargo-watch
    cargo-flamegraph
    cargo-edit

    mdbook
  ];
}
