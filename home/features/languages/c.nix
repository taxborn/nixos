{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.clang
    unstable.clang-tools
    cmake
  ];
}