{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./alacritty
    ./zsh
    ./neovim
    ./gitui
  ];

  home.packages = with pkgs; [
    ripgrep
    btop
    fastfetch
  ];
}
