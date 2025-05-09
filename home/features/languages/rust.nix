{
  lib,
  pkgs,
  ...
}:
{
  # use clang/mold
  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "${lib.getExe pkgs.clang}"
    rustflags = [ "-C", "link-arg=-fuse-ld=${lib.getExe pkgs.mold}" ]
  '';

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
