{
  pkgs,
  ...
}:

{
  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      escapeTime = 300;
      mouse = true;
      historyLimit = 10000;
      keyMode = "vi";
      extraConfig = ''

      '';
      shell = "${pkgs.zsh}/bin/zsh";
    };
  };
}