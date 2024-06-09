{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./alacritty
    ./zsh
    ./neovim
  ];

  home.packages = with pkgs; [
    lazygit
    ripgrep
    btop
  ];
}
