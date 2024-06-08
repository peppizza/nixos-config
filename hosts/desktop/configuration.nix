# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./../../modules/nixos/bootloader.nix
      ./../../modules/nixos/locale.nix
      ./../../modules/nixos/display.nix
      ./../../modules/nixos/nvidia.nix
      ./../../modules/nixos/swap.nix
    ];

  networking.hostName = "nixos-desktop"; # Define your hostname.

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spencer = {
    isNormalUser = true;
    description = "Spencer Vess";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "spencer" = import ./home.nix;
    };
  };

  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    vesktop
    signal-desktop
    kicad
    qalculate-qt
    bambu-studio
    kdePackages.kmines
    prismlauncher
    thunderbird
    nh
    nix-output-monitor
    nvd
    thunderbird
    protonmail-bridge-gui
    lazygit
    wootility
    filelight
    ckb-next
    neovim
    cider
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

  systemd.tmpfiles.rules = [ "w /proc/acpi/wakeup - - - - XHC0" ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  hardware.ckb-next.enable = true;

  services.system76-scheduler.enable = true;

  system.stateVersion = "24.05"; # DO NOT EDIT

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

