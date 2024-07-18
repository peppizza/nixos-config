{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
            "<leader>ca" = "code_action";
          };
        };

        servers = {
          lua-ls.enable = true;
          tsserver.enable = true;
          ccls.enable = true;
          cmake.enable = true;
        };
      };

      rustaceanvim.enable = true;
    };
  };
}
