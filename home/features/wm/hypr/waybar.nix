{ config, ... }:

{
  home.file."${config.xdg.configHome}/waybar/style.css".source = ./waybar.css;

  programs.waybar = {
    enable = true;
    settings = {
      primary = {
        layer = "top";
        position = "top";
        height = 32;
        # https://developer.mozilla.org/en-US/docs/Web/CSS/margin
        margin = "8 8 0";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
          "network"
          "cpu"
          "memory"
          "tray"
          "custom/lock"
          "custom/power"
        ];
        "hyprland/workspaces" = {
          "format" = "{name}: {icon}";
          "format-icons" = {
            "active" = "";
            "default" = "";
          };
        };
        clock = {
          timezone = "America/Chicago";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format = "{:%Y-%m-%dT%T%Ez}";
          interval = 5;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              " "
            ];
          };
          on-click = "pavucontrol";
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
        };
        network = {
          interval = 5;
          format-wifi = "󰤢";
          format-ethernet = "󰈀";
          format-disconnected = "󰤠";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        cpu = {
          interval = 1;
          format = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };
        memory = {
          format = "  {used:0.1f}G/{total:0.1f}G";
          interval = 30;
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        "custom/lock" = {
          tooltip = false;
          on-click = "sh -c '(sleep 0.5s; hyprlock --immediate)' & disown";
          format = "";
        };
      };
    };
  };
}
