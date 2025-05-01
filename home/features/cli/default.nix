{ pkgs, ... }:

{
  imports = [
    ./fish.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    extraOptions = [
      "-l"
      "--icons"
      "--git"
      "-a"
    ];
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;

    colors = {
      "fg" = "#cdd6f4";
      "bg" = "#1e1e2e";
      "hl" = "#f38ba8";
      "fg+" = "#cdd6f4";
      "bg+" = "#313244";
      "hl+" = "#f38ba8";
      "info" = "#cba6f7";
      "prompt" = "#cba6f7";
      "pointer" = "#f5e0dc";
      "marker" = "#b4befe";
      "spinner" = "#f5e0dc";
      "header" = "#f38ba8";
      "selected-bg" = "#45475a";
      "border" = "#313244";
      "label" = "#cdd6f4";
    };
  };

  programs.bat.enable = true;

  home.packages = with pkgs; [
    coreutils
    fd
    btop
    jq
    procs
    ripgrep
    zip
  ];
}
