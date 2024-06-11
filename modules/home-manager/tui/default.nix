{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./alacritty
    ./zsh
    ./neovim
    ./gitui
    ./btop
  ];

  home.packages = with pkgs; [
    ripgrep
    fastfetch
  ];
}
