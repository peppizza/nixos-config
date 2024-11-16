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
          lua_ls.enable = true;
          ts_ls.enable = true;
          ccls.enable = true;
          cmake.enable = true;
        };
      };

      rustaceanvim.enable = true;
    };

    extraFiles."after/ftplugin/rust.lua".text = ''
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set(
        "n",
        "<leader>ca",
        function()
          vim.cmd.RustLsp('codeAction')
        end,
        { silent = true, buffer = bufnr }
      )
    '';
  };
}
