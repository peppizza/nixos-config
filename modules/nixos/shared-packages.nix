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
    kdePackages.filelight
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
    warpinator
    man-pages
    nixfmt-rfc-style
    ungoogled-chromium
    yubioath-flutter
    prismlauncher
    # cider2
    gimp
    ani-cli
    wineWowPackages.waylandFull
    winetricks
    wineasio
    onlyoffice-bin
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

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
}
