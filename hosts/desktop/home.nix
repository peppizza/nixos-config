{
  home.username = "spencer";
  home.homeDirectory = "/home/spencer";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/tui
    ../../modules/home-manager/osu
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
