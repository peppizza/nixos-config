{ config, ... }:
{
  home.username = "spencer";
  home.homeDirectory = "/home/spencer";

  home.stateVersion = "24.05";

  imports = [
    ../../modules/home-manager/tui
  ];

  services.easyeffects.enable = true;
  xdg.configFile."easyeffects/output/fw16profile.json".source = ./FW16effects.json;

  programs.home-manager.enable = true;
}
