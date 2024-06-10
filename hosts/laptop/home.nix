{ config, ... }:
{
  home.username = "spencer";
  home.homeDirectory = "/home/spencer";

  home.stateVersion = "24.05";

  imports = [
    ../../modules/home-manager/tui
    ../../modules/home-manager/osu
  ];

  services.easyeffects.enable = true;
  services.easyeffects.preset = "fw16profile";
  xdg.configFile."easyeffects/output/fw16profile.json".source = ./FW16effects.json;
  systemd.user.services.easyeffects.Service.ExecStartPost = [
    "${config.services.easyeffects.package}/bin/easyeffects --load-preset ${config.services.easyeffects.preset}"
  ];

  programs.home-manager.enable = true;
}
