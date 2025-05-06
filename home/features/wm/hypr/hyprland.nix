{
  pkgs,
  config,
  lib,
  hostname,
  ...
}:
with lib;
let
  cfg = config.features.wm.hyprland;
in
{

  options.features.wm.hyprland.enable = mkEnableOption "enable hyprland integration";

  imports = [
    ./waybar.nix
    ./wofi.nix
    ./hyprlock.nix
    ./hyprpaper.nix

    # setup some per-device settings
    (if hostname == "uranium" then ../../../uranium/hyprland.nix else ../../../tungsten/hyprland.nix)
  ];

  config = mkIf cfg.enable {
    services.dunst.enable = true;

    home.persistence."/persist/home/taxborn" = {
      directories = [
        # hyprland uses wireplumber, we should save the state
        ".local/state/wireplumber"
      ];
    };

    home.packages = with pkgs; [
      grim
      slurp
      waypipe
      pavucontrol
      wf-recorder
      playerctl
      wl-mirror
      ydotool
      brightnessctl
      wl-clipboard
    ];

    home.sessionVariables = lib.mkMerge [
      {
        EDITOR = "nvim";
        TERMINAL = "ghostty";
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland,x11";
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
      }
      (lib.optionalAttrs (hostname == "uranium") { WLR_RENDERER = "vulkan"; })
      (lib.optionalAttrs (hostname == "tungsten") {
        GBM_BACKEND = "nvidia-drm";
        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        __GL_VRR_ALLOWED = "1";
      })
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd = {
        enable = true;
        # Same as default, but stop graphical-session too
        extraCommands = lib.mkBefore [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
        variables = [
          "DISPLAY"
          "HYPRLAND_INSTANCE_SIGNATURE"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
      };

      settings = {
        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 2;
          "col.active_border" = "rgba(b4befeff)";
          "col.inactive_border" = "rgba(1e1e2eff)";
          layout = "dwindle";
        };

        xwayland = {
          force_zero_scaling = true;
        };

        exec-once = [
          "waybar"
          "ghostty"
          "firefox"
          "dunst"
          "hypridle"
          "hyprpaper"
        ];

        env = [
          "XCURSOR_SIZE,32"
          "WLR_NO_HARDWARE_CURSORS,1"
          "GTK_THEME,Dracula"
        ];

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 1;

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          touchpad = {
            natural_scroll = true;
          };
        };

        decoration = {
          shadow = {
            enabled = true;
            range = 60;
            offset = "1 2";
            render_power = 3;
            scale = 0.97;
          };
          rounding = 0;
          blur = {
            enabled = true;
            size = 3;
            passes = 3;
          };
          active_opacity = 0.95;
          inactive_opacity = 0.8;
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = { };

        gestures = {
          workspace_swipe = false;
        };

        "$mainMod" = "SUPER";

        bind = [
          "$mainMod, return, exec, ghostty"
          "$mainMod, Escape, exec, wlogout -p layer-shell"
          "$mainMod, q, killactive"
          "$mainMod, M, exit"

          "Alt, Space, exec, wofi --show drun --allow-images"
          "Alt SHIFT, Space, exec, wofi-emoji"
          "$mainMod, L, exec, hyprlock"

          "$mainMod, Space, togglefloating"
          "$mainMod, F, fullscreen"
          "$mainMod SHIFT, P, pseudo"
          "$mainMod, J, togglesplit"

          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ];

        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
      };

      extraConfig = ''
        # Ignore maximize requests from apps. You'll probably like this.
        windowrule = suppressevent maximize, class:.*

        # Fix some dragging issues with XWayland
        windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
      '';
    };
  };
}
