{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Braxton Fair";
    userEmail = "hello@taxborn.com";

    signing = {
      key = "9BC40CD3E8BA5EF2";
      signByDefault = true;
    };
  };
}
