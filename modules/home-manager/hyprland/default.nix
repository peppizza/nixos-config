{ pkgs, inputs, ... }:
{
  imports = [
    ../waybar/hypr.nix
    ../tofi.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./mpd.nix
  ];

  services = {
    udiskie.enable = true;
    dunst = {
      enable = true;
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.packages = with pkgs; [
    networkmanagerapplet
    grim
    slurp
    hyprpicker
    brightnessctl
    wl-clipboard
    inputs.swww.packages.${pkgs.system}.swww
  ];

  xdg.configFile."wallpaper.png".source = ../../../wallpaper.png;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,2560x1600@165,0x0,1.6,vrr,2";
      workspace = "eDP-1,1";

      exec-once = [
        "tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE \"$HYPRLAND_INSTANCE_SIGNATURE\""
        "waybar"

        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME"
        "dunst"
        "xrandr --output XWAYLAND0 --primary"
        "nm-applet --indicator"
        "udiskie"
        "hypridle"
        "blueman-applet"
        "swww-daemon"
        "kdeconnectd"
      ];

      exec = "sleep 0.3; swww img ~/.config/wallpaper.png";

      xwayland.force_zero_scaling = true;

      env = [
        "XCURSOR_SIZE,24"
        "GDK_SCALE,1.6"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 6;

        border_size = 2;

        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

      };

      misc = {
        enable_swallow = true;
        swallow_regex = "^(Alacritty)$";
      };

      decoration = {
        rounding = 5;

        blur = {
          enabled = true;
          size = 10;
          passes = 1;
          new_optimizations = true;
          xray = true;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
        dim_inactive = false;
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 0%"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      input = {
        kb_layout = "us";
        numlock_by_default = true;

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
          clickfinger_behavior = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
        workspace_swipe_create_new = false;
      };

      windowrule = [
        "float, tile:^(VimWiki)$"
        "float, class:.*.exe"
        "float, class:steam_app_.*"
        "float, class:steam_proton"
      ];

      windowrulev2 = [
        "workspace 4, class:^(vesktop)$"
        "workspace 3, class:^(Cider)$"
        "workspace 5, class:^(signal)$"
        "fullscreen, class:^(mpv)$"
        "opacity 0.93 0.93, class:^(Alacritty)$"
        "fullscreen, class:^(gamescope)"
      ];

      "$mainMod" = "SUPER";

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, Control_L, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod, ALT_L, resizewindow"
      ];

      binde = [
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"

        ",XF86MonBrightnessUp, exec, brightnessctl -s set +25"
        ",XF86MonBrightnessDown, exec, brightnessctl -s set 25-"
      ];

      bind =
        [
          ",XF86AudioPlay, exec, playerctl -p \"playerctld\" play-pause"
          ",XF86AudioPrev, exec, playerctl -p \"playerctld\" previous"
          ",XF86AudioNext, exec, playerctl -p \"playerctld\" next"
          ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

          "SHIFT, Print, exec, slurp | grim -g - - | wl-copy"
          ",Print, exec, grim - | wl-copy"
          "$mainMod, P, exec, hyprpicker -a -f hex"

          "$mainMod, Return, exec, alacritty"
          "$mainModSHIFT, Q, killactive"
          "$mainMod, D, exec, tofi-run | xargs -0 hyprctl dispatch exec"
          "$mainMod, Q, exec, firefox"
          "$mainMod, F1, exec, alacritty -e ncmpcpp"
          "$mainMod ALT, F, exec, dolphin"
          "$mainMod ALT, S, exec, cider --ozone-platform=wayland"
          "$mainMod ALT, S, exec, vesktop"
          "$mainMod ALT, S, exec, signal-desktop"
          "$mainMod ALT, O, exec, gamemoderun gamescope -W 2560 -H 1600 -r 165 osu\\!"

          "$mainMod, O, togglefloating"
          "$mainMod, F, fullscreen, 0"
          "$mainMod, Space, togglesplit"

          "$mainMod ALT, L, exec, loginctl lock-session"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainModSHIFT, h, movewindow, l"
          "$mainModSHIFT, l, movewindow, r"
          "$mainModSHIFT, k, movewindow, u"
          "$mainModSHIFT, j, movewindow, d"
        ]
        ++ (
          # workspaces
          # binds $mainMod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainModSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
    };
  };
}
