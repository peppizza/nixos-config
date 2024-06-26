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
    ffmpeg-full
    mpv
    cinnamon.warpinator
    man-pages
    nixfmt-rfc-style
    ungoogled-chromium
    yubikey-manager
    yubikey-manager-qt
  ];

  programs.kdeconnect.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
      {
        from = 42000;
        to = 42001;
      } # Warpinator
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
      {
        from = 42000;
        to = 42000;
      } # Warpinator
    ];
  };
}
