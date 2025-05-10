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
      atkinson-hyperlegible-mono
    ];

    fontconfig = {
      defaultFonts.emoji = [ "Noto Color Emoji" ];
      useEmbeddedBitmaps = true;
    };
  };
}
