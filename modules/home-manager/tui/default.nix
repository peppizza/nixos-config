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

  stylix.targets = {
    tmux.enable = false;
    alacritty.enable = false;
    nixvim.enable = false;
    gitui.enable = false;
    btop.enable = false;
  };
}
