{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/display.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/amdgpu.nix
    ../../modules/nixos/shared-packages.nix
    ../../modules/nixos/hyprland.nix
    # ../../modules/nixos/illuminanced
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };
  };

  networking.hostName = "nixos-laptop";
  networking.networkmanager.wifi.backend = "iwd";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  programs.zsh.enable = true;

  users.users.spencer = {
    isNormalUser = true;
    description = "Spencer Vess";
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
    shell = pkgs.zsh;
    initialPassword = "123456";
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  environment.sessionVariables = {
    FLAKE = "/home/spencer/nixos-config";
  };

  environment.pathsToLink = [ "/share/zsh" ];

  hardware.opentabletdriver.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.system76-scheduler.enable = true;

  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = false;

  services.power-profiles-daemon.enable = true;

  programs.dconf.enable = true;

  services.fwupd.enable = true;

  system.stateVersion = "24.05"; # DO NOT CHANGE

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
