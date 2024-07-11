{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh
    fzf
    eza
    zoxide
    atuin
    oh-my-posh
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
      };

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "14e16f0d36ae9938e28b2f6efdb7344cd527a1a6";
            sha256 = "sha256-o8hgnTl84nI7jMVfA5jEcDXkMFFlnxKbRva+l/Fx4jI=";
          };
        }
      ];

      history = {
        size = 5000;
        path = "$HOME/.zsh_history";
        ignoreAllDups = true;
      };

      shellAliases = {
        c = "clear";
        ".." = "cd ..";
        lg = "lazygit";
      };

      initExtra = ''
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        bindkey "^F" autosuggest-accept

        zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
        zstyle ":completion:*" list-colors "''${(s.:.)LS_COLORS}"
        zstyle ":completion:*" menu no
        zstyle ":completion:*:git-checkout:*" sort false
        zstyle ":completion:*:descriptions" format "[%d]"
        zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1 --color=always $realpath"
        zstyle ":fzf-tab:*" switch-groups "<" ">"
        zstyle ":fzf-tab:*" fzf-command ftb-tmux-popup
        zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "eza -1 --color=always $realpath"

        eval "fastfetch | blahaj"

        eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"
      '';
    };

    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };

    eza.enable = true;

    zoxide.enable = true;
    zoxide.options = [
      "--cmd"
      "cd"
    ];

    atuin.enable = true;
  };

  xdg.configFile."oh-my-posh/zen.toml" = {
    enable = true;
    source = ./ohmyposh/zen.toml;
  };
}
