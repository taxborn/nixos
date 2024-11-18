{ pkgs, ... }:

{
  programs = {
    tmux = {
      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = true;
      enable = true;
      escapeTime = 300; # nvim recommended
      extraConfig = ''
        set-option -sa terminal-features ',alacritty:RGB'
      '';
      historyLimit = 10000;
      keyMode = "vi";
      mouse = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";

      plugins = with pkgs.tmuxPlugins; [
        catppuccin # TODO: This recently had a 2.0 update and looks a lot better, should look at switching
        tmux-fzf
        vim-tmux-navigator
        yank
      ];
    };
  };
}
