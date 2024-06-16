{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
  ];

  programs.ncmpcpp.enable = true;

  services.playerctld.enable = true;

  services.mpd = {
    enable = true;

    extraConfig = ''
      audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
      }
    '';
  };

  services.mpd-mpris.enable = true;
}
