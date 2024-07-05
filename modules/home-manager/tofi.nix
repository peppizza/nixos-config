{
  programs.tofi = {
    enable = true;

    settings = {
      anchor = "bottom";
      width = "100%";
      height = 28;
      horizontal = true;
      font-size = 14;
      font = "JetBrainsMono-Medium";
      prompt-text = "Enter Input > ";
      outline-width = 0;
      border-width = 0;
      # background-color = "#1d1f21";
      # selection-color = "#268bd2";
      selection-background = "#444";
      num-results = 10;
      min-input-width = 240;
      result-spacing = 20;
      padding-top = 2;
      padding-bottom = 0;
      padding-left = 5;
      padding-right = 0;
      hint-font = false;
      placeholder-text = "input";
    };
  };
}
