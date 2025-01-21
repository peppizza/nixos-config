{
  programs.nixvim.plugins.floaterm = {
    enable = true;

    settings = {
      keymap_toggle = "<leader>,";

      width = 0.8;
      height = 0.8;

      title = "";
    };
  };
}
