{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pcmanfm
  ];

  xdg.configFile."pcmanfm/default/pcmanfm.conf".source = ./pcmanfm.conf;
}
