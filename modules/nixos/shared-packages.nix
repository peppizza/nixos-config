{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    vesktop
    signal-desktop
    kdePackages.kmines
    thunderbird
    nh
    nix-output-monitor
    nvd
    protonmail-bridge-gui
    wootility
    filelight
    qalculate-qt
    osu-lazer-bin
  ];
}
