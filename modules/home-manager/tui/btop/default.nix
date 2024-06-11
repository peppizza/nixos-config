{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha";
      vim_keys = true;
    };
  };

  xdg.configFile."btop/themes/catppuccin_mocha.theme".source = ./catppuccin_mocha.theme;
}
