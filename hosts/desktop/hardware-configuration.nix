# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2bb3a4f8-76e5-470d-9f2a-7f9ffdc71cac";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/2bb3a4f8-76e5-470d-9f2a-7f9ffdc71cac";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/2bb3a4f8-76e5-470d-9f2a-7f9ffdc71cac";
    fsType = "btrfs";
    options = [
      "subvol=@log"
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/909A-1D44";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2bb3a4f8-76e5-470d-9f2a-7f9ffdc71cac";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
    ];
  };

  fileSystems."/media/ssd" = {
    device = "/dev/disk/by-uuid/58162967-ebbd-4876-8bea-441d5d2dd2b7";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  fileSystems."/media/hdd" = {
    device = "/dev/disk/by-uuid/e3457adf-d9d6-4663-8928-e42c457930b9";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.auto-epp.enable = true;
}
