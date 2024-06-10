{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;

      registrations = {
        "<leader>f" = "Telescope commands";
        "<leader>g" = "Gitsigns commands";
      };
    };

    opts = {
      timeout = true;
      timeoutlen = 300;
    };
  };
}
