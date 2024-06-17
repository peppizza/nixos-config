{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
  ];

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      visualizer_type = "spectrum";
      visualizer_look = "+|";
    };
  };

  services.playerctld.enable = true;

  services.mpd = {
    enable = true;

    extraConfig = ''
      audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
      }

      audio_output {
        type                    "fifo"
        name                    "my_fifo"
        path                    "/tmp/mpd.fifo"
        format                  "44100:16:2"
      }
    '';
  };

  services.mpd-mpris.enable = true;
}
