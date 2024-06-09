{
  programs.nixvim.plugins.telescope = {
    enable = true;

    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>b" = "buffers";
      "<leader>fh" = "help_tags";
      "<leader>fd" = "diagnostics";
    };

    settings.defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache"
        "^__pycache__/"
        "^output/"
        "^data/"
      ];
      set_env.COLORTERM = "truecolor";
    };

    extensions.ui-select.enable = true;
  };
}
