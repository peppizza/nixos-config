{
  services.easyeffects.enable = true;
  xdg.configFile."easyeffects/output/fw16profile.json".source = ./FW16effects.json;
  xdg.configFile."easyeffects/output/none.json".source = ./none.json;

  xdg.configFile."easyeffects/autoload/output/alsa_output.pci-0000_c1_00.6.analog-stereo:analog-output-speaker.json".source = ./speaker.json;
  xdg.configFile."easyeffects/autoload/output/alsa_output.usb-Framework_Audio_Expansion_Card-00.analog-stereo:analog-output.json".source = ./audiojack.json;
}
