{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    gamescopeSession = {
      enable = true;
      # TODO: idk why but I can't get this to display on my main monitor.
      env = {
        # TODO: What would it be for nvidia?
        WLR_RENDERER = "vulkan";
        # ENABLE_GAMESCOPE_WSI = "1";
        # WINE_FULLSCREEN_FSR = "1";
      };
      args = [
        "--output-width"
        "2560"
        "--output-height"
        "1440"
        # "--adaptive-sync"
        "--steam"
        "--prefer-output"
        "DP-5"
        "--prefer-vk-device"
        "1002:744c"
      ];
    };

    extraPackages = with pkgs; [
      gamescope
      xwayland-run
      protonup-ng # latest and greatest proton
      dolphin-emu # mario kart one day?
    ];
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  programs.steam.package =
    let
      x-wrapped =
        steam:
        pkgs.runCommand "x-run-steam" { inherit (steam) passthru meta; } ''
          cp -r ${steam} $out

          # $out/share is a symlink to ${steam}/share
          # but since we need to edit its internals, we need to expand it to a real directory
          # that can be edited

          # first we need to make sure we can remove it
          chmod -R +w $out

          # then remove, recreate, and populate it
          rm $out/share
          mkdir $out/share
          cp -r ${steam}/share/* $out/share/

          # and of course, make sure we can edit the desktop file again
          chmod -R +w $out

          sed -i 's/Exec=steam/Exec=x-run steam/g' $out/share/applications/steam.desktop
        '';
    in
    x-wrapped pkgs.steam
    // {
      override = f: x-wrapped (pkgs.steam.override f);
    };
}
