{ ... }:

{
  home.persistence."/persist/home/taxborn" = {
    directories = [
      ".mozilla/firefox"
      ".cache/mozilla/firefox"
    ];
  };

  programs.firefox.enable = true;
}
