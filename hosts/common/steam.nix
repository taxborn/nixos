{
  programs = {
    steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;

      gamescopeSession.enable = true;
    };

    gamescope = {
      enable = true;
      capSysNice = true; # what does this do?
    };
  };
}
