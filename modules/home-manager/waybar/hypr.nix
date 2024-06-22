{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pulsemixer
    helvum
  ];

  programs.waybar = {
    enable = true;

    style = ''
      * {
        font-family: Jetbrains Mono Medium;
        font-size: 10pt;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #waybar.empty #window {
        background-color: transparent;
      }

      #window {
        margin: 2;
        padding-left: 8;
        padding-right: 8;
        background-color: rgba(0,0,0,0.3);
        font-size: 14px;
        font-weight: bold;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }

      button:hover {
        background: inherit;
        border-top: 2px solid #c9545d;
      }

      #workspaces button {
        padding: 0 4px;
      }

      #workspaces button:hover {
      }

      #workspaces button.focused {
        background-color: rgba(0,0,0,0.3);
        color: #c9545d;
        border-top: 2px solid #c9545d;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #mode {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }

      #workspaces,
      #clock,
      #battery,
      #disk,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpris,
      #power-profiles-daemon {
        margin: 2px;
        padding-left: 5px;
        padding-right: 7px;
        background-color: rgba(0,0,0,0.3);
        color: #ffffff;
      }

      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #clock {
        font-size: 14px;
        font-weight: bold;
      }

      #battery icon {
        color: red;
      }

      #battery.charging, #battery.plugged {
        color: #ffffff;
        background-color: #26A65B;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }

      #battery.warning:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #power-profiles-daemon {
         padding-right: 15px;
         padding-left: 7.5px;
      }

      #power-profiles-daemon.performance {
        background-color: #f53c3c;
        color: #ffffff;
      }

      #power-profiles-daemon.balanced {
        background-color: #2980b9;
        color: #ffffff;
      }

      #power-profiles-daemon.power-saver {
        background-color: #2ecc71;
        color: #000000;
      }

      label:focus {
        background-color: #000000;
      }

      #network.disconnected {
        background-color: #f53c3c;
      }

      #idle_inhibitor {
        padding-right: 10px;
      }

      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3446;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }
    '';

    settings = {
      mainBar = {
        height = 24;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "mpris"
          "idle_inhibitor"
          "network"
          "wireplumber"
          "backlight"
          "battery"
          "power-profiles-daemon"
          "tray"
          "clock"
        ];

        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          dynamic-len = 30;
          format-paused = "{status_icon} <i>{dynamic}</i>";
          interval = 2;
          player-icons = {
            default = "";
            mpd = "󰝚";
            cider = "";
            mpv = "";
            firefox = "";
          };
          status-icons = {
            paused = "";
            playing = "";
          };
        };

        idle_inhibitor = {
          format = "{icon} ";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        tray.spacing = 10;

        clock = {
          format = "{:%a %I:%M %p}";
          tooltip-format = "<big>{:%Y %B %d}</big>\n<tt><small>{calendar}</small></tt>";
        };

        backlight = {
          format = "{icon}  {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        battery = {
          # bat = "BAT1";
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}   {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{icon}   {time}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-ethernet = "󰈀  {ifname}";
          tooltip-format = "   {ifname} via {gwaddr}";
          format-linked = "   {ifname} (No IP)";
          format-disconnected = "Disconnected ⚠ {ifname}";
          format-alt = "   {ifname}: {ipaddr}/{cidr}";
        };

        wireplumber = {
          scroll-step = 5;
          format = "{icon}   {volume}% {node_name}";
          format-bluetooth = " {icon}  {volume}% {node_name}";
          format-bluetooth-muted = "  {icon}  {node_name}";
          format-muted = " {node_name}";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "alacritty -e pulsemixer";
          on-click-right = "helvum";
          ignored-sinks = [ "Easy Effects Sink" ];
        };
      };
    };
  };
}
