{
  programs.nixvim = {
    globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;
    };

    clipboard = {
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    opts = {
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      number = true;
      showmode = false;
      scrolloff = 999;
      relativenumber = true;
    };
  };
}
