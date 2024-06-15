{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./alacritty.nix
    ./zsh
    ./neovim
    ./btop.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    fastfetch
  ];

  programs.lazygit.enable = true;
}
