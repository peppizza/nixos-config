{ config, lib, ... }:
let
  helpers = config.lib.nixvim;
in
  {
    programs.nixvim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      keymaps =
        let
          normal =
            lib.mapAttrsToList
              (key: action: {
                mode = "n";
                inherit action key;
              })
              {
                "<Space>" = "<NOP>";

                # Clear search results with escape
                "<esc>" = ":noh<CR>";

                # Move current line up/down with alt+k/j
                "<M-k>" = ":move-2<CR>";
                "<M-j>" = ":move+<CR>";
              };
          visual =
            lib.mapAttrsToList
              (key: action: {
                mode = "v";
                inherit action key;
              })
              {
                # Move slected block of text in visual mode
                "K" = ":m '<-2<CR>gv=gv";
                "J" = ":m '>+1<CR>gv=gv";
              };
          terminal = lib.mapAttrsToList (key: action: {
            mode = "t";
            inherit action key;
          }) { "<ESC><ESC>" = "<C-\\><C-n>"; };
        in
          helpers.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ terminal);
    };
  }
