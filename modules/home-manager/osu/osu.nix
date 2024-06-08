{ lib, ... }:

{
  xdg.desktopEntries.osu-lazer = {
    type = "Application";
    name = "osu!lazer";
    mimeType = [ "application/x-osu-skin-archive" "application/x-osu-replay" "application/x-osu-beatmap-archive" ];
    icon = ./icon.png;
    exec = "osu\\ !";
    comment = "Open source free-to-win rhythm game";
    categories = [ "Game" ];
  };
}
