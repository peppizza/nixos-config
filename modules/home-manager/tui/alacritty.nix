{
  programs.alacritty.enable = true;

  programs.alacritty.settings = {
    live_config_reload = true;
    mouse.hide_when_typing = true;
    bell = {
      animation = "EaseOutExpo";
      duration = 0;
    };
    colors.draw_bold_text_with_bright_colors = true;
    font = {
      bold = {
        family = "JetBrainsMono Nerd Font";
        style = "Bold";
      };
      glyph_offset.x = 0;
      glyph_offset.y = 0;
      italic.family = "JetBrainsMono Nerd Font";
      normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      size = 14;
    };
    env.TERM = "xterm-256color";
    window = {
      decorations = "none";
      startup_mode = "Maximized";
    };

    shell.program = "tmux";
  };
}
