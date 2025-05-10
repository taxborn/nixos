{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    disableConfirmationPrompt = true;
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      tmux-fzf
      catppuccin
      sensible
    ];
  };
}
