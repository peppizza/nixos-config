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
    nvme-cli
    usbutils
    aha
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
    ffmpeg
  ];

  programs.kdeconnect.enable = true;

  networking.firewall = {
  enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };
}
