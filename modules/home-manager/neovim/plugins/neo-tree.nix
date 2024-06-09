{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<C-n>";
        action = ":Neotree filesystem reveal left<CR>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true;

      closeIfLastWindow = true;

      extraOptions = {
        filesystem = {
          filtered_items = {
            visible = true;
            hide_dotfiles = false;
            hide_gitignored = true;
            never_show = [ ".git" ];
          };
        };
      };
    };
  };
}
