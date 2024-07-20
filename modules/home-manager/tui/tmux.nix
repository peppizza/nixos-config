{ pkgs, ... }:
{
  home.packages = with pkgs; [ wl-clipboard ];

  programs.tmux = {
    enable = true;
    mouse = true;

    prefix = "C-space";

    baseIndex = 1;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-select
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      }
    ];

    keyMode = "vi";

    escapeTime = 0;

    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g default-terminal "screen-256color"

      bind -n M-H previous-window
      bind -n M-L next-window
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
