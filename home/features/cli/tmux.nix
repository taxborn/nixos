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
      baseIndex = 1;
      terminal = "tmux-256color";
      historyLimit = 10000;
      keyMode = "vi";
      shell = "${pkgs.zsh}/bin/zsh";

      plugins = with pkgs.tmuxPlugins; [
        tmux-fzf
        vim-tmux-navigator
        catppuccin # TODO: This recently had a 2.0 update and looks a lot better, should look at switching
        yank
      ];

      extraConfig = ''
        set-option -sa terminal-features ',alacritty:RGB'
      '';
    };
  };
}