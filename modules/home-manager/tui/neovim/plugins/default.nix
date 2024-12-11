{
  imports = [
    ./neo-tree.nix
    ./floaterm.nix
    ./lsp.nix
    ./alpha.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
      settings.integrations = {
        cmp = true;
        gitsigns = true;
        treesitter = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gt";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options.silent = true;
      }
    ];

    plugins = {
      lualine = {
        enable = true;
        settings.options.theme = "dracula";
      };

      web-devicons.enable = true;

      gitsigns.enable = true;

      tmux-navigator.enable = true;

      fugitive.enable = true;

      nvim-autopairs.enable = true;

      neocord.enable = true;

      colorizer = {
        enable = true;
        settings.user_default_options.names = false;
      };

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}
