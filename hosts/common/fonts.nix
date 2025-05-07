{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      liberation_ttf
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk-sans

      nerd-fonts.jetbrains-mono
      atkinson-hyperlegible-next
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Atkinson Hyperlegible Next" ];
        sansSerif = [ "Atkinson Hyperlegible Next" ];
        monospace = [ "JetBrainsMonoNL Nerd Fono Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
      useEmbeddedBitmaps = true;
    };
  };
}
