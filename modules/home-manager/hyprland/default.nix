{ pkgs, ... }:
{
  imports = [
    ../waybar/hypr.nix
    ../tofi.nix
  ];
  services.udiskie.enable = true;
  services.dunst.enable = true;
  services.mpd.enable = true;
  programs.hyprlock = {
    enable = true;
    settings= {
      general = {
        disable_loading_bar = true;
        grace = 3;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "~/.config/wallpaper.jpg";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "'Password...'";
          shadow_passes = 2;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150; # 2.5 minutes
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300; # 5 minutes
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330; # 5.5 minutes
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpmms on";
        }
        {
          timeout = 1800; # 30 minutes
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
  xdg.userDirs.enable = true;

  home.packages = with pkgs; [
    swaybg
    networkmanagerapplet
    grim
    slurp
    hyprpicker
    ncmpcpp
    brightnessctl
    wl-clipboard
    playerctl
  ];

  xdg.configFile."wallpaper.jpg".source = ./wallpaper.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,2560x1600@165,0x0,1.6";
      workspace = "eDP-1,1";

      exec-once = [
        "tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE \"$HYPRLAND_INSTANCE_SIGNATURE\""
        "waybar"
        "swaybg -i ~/.config/wallpaper.jpg"

        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
        "dunst"
        "xrandr --output XWAYLAND0 --primary"
        "nm-applet --indicator"
        "udiskie"
        "mpd"
        "hypridle"
      ];

      env = "XCURSOR_SIZE,24";

      general = {
        gaps_in = 3;
        gaps_out = 6;

        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

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
        "col.shadow" = "rgba(1a1a1aee)";
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

      master.new_is_master = true;

      input = {
        kb_layout = "us";
        numlock_by_default = true;

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          middle_button_emulation = true;
          scroll_factor = 0.5;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      windowrule = [
        "float, tile:^(VimWiki)$"
        "float, class:.*.exe"
        "float, class:steam_app_.*"
        "float, class:steam_proton"
      ];

      windowrulev2 = [
        "workspace 4, class:^(vesktop)$"
        "workspace 3, class:^(cider)$"
        "fullscreen, class:^(mpv)$"
        "opacity 0.93 0.93, class:^(Alacritty)$"
      ];

      "$mainMod" = "SUPER";

      bind = [
        ",XF86AudioPlay, exec, playerctl -p \"cider\" play-pause"
        ",XF86AudioPrev, exec, playerctl -p \"cider\" previous"
        ",XF86AudioNext, exec, playerctl -p \"cider\" next"
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

        ",XF86MonBrightnessUp, exec, brightnessctl -s set +25"
        ",XF86MonBrightnessDown, exec, brightnessctl -s set 25-"

        "SHIFT, Print, exec, slurp | grim -g - $(xdg-user-dir PICTURES)/$(date +'%s_grim.png')"
        ",Print, exec, grim - | wl-copy"

        "$mainMod, Return, exec, alacritty"
        "$mainModSHIFT, Q, killactive"
        "$mainMod, D, exec, tofi-run | xargs -0 hyprctl dispatch exec"
        "$mainMod, Q, exec, firefox"
        "$mainMod, F1, exec, alacritty -e ncmpcpp"
        "$mainMod ALT, F, exec, dolphin"
        "$mainMod ALT, S, exec, cider --ozone-platform=wayland"
        "$mainMod ALT, S, exec, vesktop"

        "$mainMod, O, togglefloating"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, Space, togglesplit"

        # "$mainMod, P, exec, hyprpicker -a -f hex"

        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainModSHIFT, h, movewindow, l"
        "$mainModSHIFT, l, movewindow, r"
        "$mainModSHIFT, k, movewindow, u"
        "$mainModSHIFT, j, movewindow, d"

        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindowpixel"
      ] ++ (
        # workspaces
        # binds $mainMod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
            "$mainModSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
      );
    };
  };
}
