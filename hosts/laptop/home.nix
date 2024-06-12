{
  home.username = "spencer";
  home.homeDirectory = "/home/spencer";

  home.stateVersion = "24.05";

  imports = [
    ../../modules/home-manager/tui
    ../../modules/home-manager/easyeffects
    ../../modules/home-manager/hyprland
  ];

  programs.home-manager.enable = true;
}
