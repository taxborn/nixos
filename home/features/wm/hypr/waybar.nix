{ config, ... }:

{
  home.file."${config.xdg.configHome}/waybar/style.css".source = ./waybar.css;
  programs.waybar = {
    enable = true;
    settings = {
      primary = {
        height = 32;
        # https://developer.mozilla.org/en-US/docs/Web/CSS/margin
        margin = "8 8 0";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap" # ???
        ];
        modules-center = [
          "cpu"
          "memory"
          "clock"
        ];
        modules-right = [
          "tray"
          "network"
          "pulseaudio"
          "battery"
        ];
        clock = {
          interval = 1;
          format = "{:%Y-%m-%d %H:%M:%S}";
          format-alt = "{:%Y-%m-%dT%H:%M:%S%z}";
          on-click-left = "mode";
          tooltip-format = ''
                          <big>{:%Y %B}</big>
                          <tt><small>{calendar}</small></tt>
            	    '';
        };
        cpu = {
          format = "  {usage}%";
        };
        memory = {
          format = "  {}%";
          interval = 5;
        };
        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };
        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
      };
    };
  };
}
