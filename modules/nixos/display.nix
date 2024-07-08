{
  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    options = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
