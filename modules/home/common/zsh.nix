{ pkgs, lib, ... }:

{
  # https://mynixos.com/home-manager/options/programs.zsh
  programs.zsh = {
    enable = true;

    # Turn on zsh auto-completion framework which gives command completion (e.g.
    # `git <tab>`) and option completion (
    enableCompletion = true;

    # Be explicit about what bindings are being used.
    # Run `zle -la | ag fzf` for a list of available widgets.
    initContent = ''
      fpath=("$HOME/.config/zsh/completions" $fpath)

      # FZF keybindings
      bindkey '^R' fzf-history-widget
      bindkey '^T' fzf-file-widget
      bindkey '^I' fzf-completion

      # Make mid-word completions work. This allows you to type '.lock' and have
      # 'myfile.locl' be completed correctly.
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=* r:|=*'
    '';

    # Installs the `zsh-autosuggestion` plugin which suggests commands as you
    # type. I personally find this visually distracting, so be explicit about
    # not having it.
    #
    # https://github.com/zsh-users/zsh-autosuggestions
    autosuggestion.enable = false;
    
    syntaxHighlighting.enable = true;

    # See also 'home.shellAliases' for aliases shared across all shells.
    shellAliases = {
    };
  };

  programs.zsh.plugins = [
    {
      name = "fzf-tab";
      src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
    }
    # https://github.com/zsh-users/zsh-autosuggestions
    # {
    #   name = "zsh-autosuggestions";
    #   src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    # }
    # {
    #   name = "zsh-completions";
    #   src = "${pkgs.zsh-completions}/share/zsh-completions";
    # }
  ];
}
