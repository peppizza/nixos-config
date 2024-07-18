# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/display.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/shared-packages.nix
    ../../modules/nixos/nixsettings.nix
    ../../modules/nixos/sddm.nix
    ../../modules/nixos/udev
  ];

  security.pam.services.sddm.kwallet.enable = true;
  services.desktopManager.plasma6.enable = true;

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "nixos-desktop"; # Define your hostname.

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spencer = {
    isNormalUser = true;
    description = "Spencer Vess";
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "video"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    initialPassword = "123456";
  };

  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kicad
    bambu-studio
    graalvm-ce
    ckb-next
  ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  environment.sessionVariables = {
    FLAKE = "/home/spencer/nixos-config";
  };

  environment.pathsToLink = [ "/share/zsh" ];

  programs.steam.enable = true;

  hardware.opentabletdriver.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  systemd.services."no_wakeup_usb" = {
    description = "Disable usb wakeup";
    script = ''
      echo XHC0 > /proc/acpi/wakeup
    '';
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = false;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  programs.virt-manager.enable = true;

  hardware.ckb-next.enable = true;

  services.system76-scheduler.enable = true;

  services.btrfs.autoScrub.enable = true;

  stylix = {
    enable = true;
    image = ../../wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };

  system.stateVersion = "24.05"; # DO NOT EDIT
}
