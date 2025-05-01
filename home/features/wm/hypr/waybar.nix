{ lib, ... }:

{
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
    style = ''
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;

      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMonoNL Nerd Font Mono";
          font-weight: 600;
          font-size: 14px;
      }

      window#waybar {
          background-color: alpha(@base, 0.9);
          border: 2px solid alpha(@lavender, 0.9);
          color: @text;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: @text;
      }
      */

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px @lavender;
      }

      /* you can set a style on hover for any module like this */
      #pulseaudio:hover {
          background-color: @lavender;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: @text;
      }

      #workspaces button:hover {
          background: alpha(@lavender, 0.3);
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: @red;
      }

      #mode {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #mpd {
          padding: 0 10px;
          color: @text;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
      border-top: 2px solid @lavender;
      border-bottom: 2px solid @lavender;
          background-color: @overlay2;
          color: @base;
      }

      #battery {
          background-color: @text;
          color: @base;
      }

      #battery.charging, #battery.plugged {
          color: @text;
          background-color: @green;
      }

      @keyframes blink {
          to {
              background-color: @text;
              color: @base;
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
          background-color: @red;
          color: @text;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #cpu {
            border-top: 2px solid @lavender;
            border-bottom: 2px solid @lavender;
          background-color: @sky;
          color: @base;
      }

      #memory {
      border-top: 2px solid @lavender;
      border-bottom: 2px solid @lavender;
          background-color: @peach;
          color: @base;
      }

      #disk {
          background-color: #964B00;
      }

      #network {
          background-color: @blue;
          color: @base;
          border-top: 2px solid @lavender;
          border-bottom: 2px solid @lavender;
      }

      #network.disconnected {
          background-color: @red;
      }

      #pulseaudio {
          background-color: @lavender;
          color: @base;
      }

      #pulseaudio.muted {
          background-color: @overlay1;
          color: @base;
      }

      #wireplumber {
          background-color: #fff0f5;
          color: #000000;
      }

      #wireplumber.muted {
          background-color: #f53c3c;
      }

      #custom-media {
          background-color: #66cc99;
          color: #2a5c45;
          min-width: 100px;
      }

      #temperature {
          background-color: #f0932b;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #2980b9;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
      }

      #idle_inhibitor {
          background-color: #2d3436;
      }

      #idle_inhibitor.activated {
          background-color: #ecf0f1;
          color: #2d3436;
      }

      #mpd {
          background-color: #66cc99;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #f53c3c;
      }

      #mpd.stopped {
          background-color: #90b1b1;
      }

      #mpd.paused {
          background-color: #51a37a;
      }

      #language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
      	background-color: transparent;
      }

      #privacy {
          padding: 0;
      }

      #privacy-item {
          padding: 0 5px;
          color: white;
      }

      #privacy-item.screenshare {
          background-color: #cf5700;
      }

      #privacy-item.audio-in {
          background-color: #1ca000;
      }

      #privacy-item.audio-out {
          background-color: #0069d4;
      }
    '';
  };
}
