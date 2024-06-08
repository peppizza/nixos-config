{ config, pkgs, ... }:

{
  home.username = "spencer";
  home.homeDirectory = "/home/spencer";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/alacritty/alacritty.nix
    ../../modules/home-manager/osu/osu.nix
    ../../modules/home-manager/tmux.nix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  xdg.desktopEntries.osu-lazer = {
    type = "Application";
    name = "osu!lazer";
    mimeType = [ "application/x-osu-skin-archive" "application/x-osu-replay" "application/x-osu-beatmap-archive" ];
    icon = ./icon.png;
    exec = "osu\\ !";
    comment = "Open source free-to-win rhythm game";
    categories = [ "Game" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
