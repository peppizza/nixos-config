{
  home.username = "spencer";
  home.homeDirectory = "/home/spencer";

  home.stateVersion = "24.05";

  imports = [
    ../../modules/home-manager/tui
    ../../modules/home-manager/easyeffects
    ../../modules/home-manager/hyprland
  ];

  stylix.targets.kde.enable = false;

  services.batsignal.enable = true;

  programs.home-manager.enable = true;
}
