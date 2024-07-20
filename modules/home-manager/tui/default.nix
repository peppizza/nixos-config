{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./alacritty.nix
    ./zsh
    ./neovim
    ./btop.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    blahaj
    tree
  ];

  programs.lazygit.enable = true;
  programs.bat.enable = true;
  home.shellAliases.cat = "bat";

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding.right = 1;
      };

      display.size = {
        maxPrefix = "MB";
        ndigits = 0;
      };

      modules = [
        "title"
        "separator"
        "os"
        "kernel"
        "shell"
        "wm"
        "cpu"
        {
          type = "gpu";
          key = "GPU";
        }
      ];
    };
  };
}
