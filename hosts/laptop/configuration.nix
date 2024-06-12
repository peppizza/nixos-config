{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/display.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/amdgpu.nix
    ../../modules/nixos/shared-packages.nix
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
    illuminanced
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

  systemd.services.illuminanced = {
    description = "Ambient light monitoring Service";
    documentation = [ "https://github.com/mikhail-m1/illuminanced" ];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.illuminanced}/bin/illuminanced -c /etc/illuminanced.toml";
      PIDFile = "/run/illuminanced.pid";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };

  environment.etc."illuminanced.toml".source = ./illuminanced.toml;

  system.stateVersion = "24.05"; # DO NOT CHANGE

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
