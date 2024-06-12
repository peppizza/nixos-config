{ pkgs, ... }:
{
  home.file."Pictures/wallpaper.jpg".source = ./wallpaper.jpg;
  programs.wofi.enable = true;
  programs.waybar.enable = true;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "$HOME/Pictures/wallpaper.jpg";

      wallpaper = "$HOME/Pictures/wallpaper.jpg";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      exec-once = [
        "$terminal"
        "waybar & hyprpaper & firefox"
      ];

      general = {
        gaps_in = 6;
        gaps_out = 12;

        border_size = 4;

        "col.active_border" = "0xffb072d1";
        "col.inactive_border" = "0xff292a37";

        allow_tearing = false;
      };

      decoration = {
        rounding = 8;
        drop_shadow = 0;
        shadow_range = 60;
        "col.shadow" = "0x66000000";
        blur.enabled = false;
      };

      animations = {
        enabled = true;

        animation = [
          "windows, 1, 4, default, slide"
          "border, 1, 5, default"
          "fade, 1, 5, default"
          "workspaces, 1, 3, default, slide"
        ];
      };

      dwindle.pseudotile = false;

      input = {
        kb_layout = "us";

        follow_mouse = 0;

        sensitivity = 0;
      };

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainModSHIFT, Q, killactive"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, wofi --show run --xoffset=1670 --yoffset=12 --width=230px --height=984 --term=alacritty --prompt=run"
        "$mainMod, F, fullscreen, 0"

        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainModSHIFT, h, movewindow, l"
        "$mainModSHIFT, l, movewindow, r"
        "$mainModSHIFT, k, movewindow, u"
        "$mainModSHIFT, j, movewindow, d"
      ] ++ (
        # workspaces
        # binds $mainMod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 9;
            in
              builtins.toString (x + 1 - (c * 9));
          in [
            "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
            "$mainMod, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        9)
      );
    };
  };
}
