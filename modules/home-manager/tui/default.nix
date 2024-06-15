{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./alacritty.nix
    ./zsh
    ./neovim
    ./gitui.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    fastfetch
  ];
}
