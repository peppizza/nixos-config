{ ... }:
{
  services.zram-generator.enable = true;
  services.zram-generator.settings = {
    zram0 = {
      zram-size = "ram / 2";
      compression-algorithm = "zstd";
    };
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
}
