{ pkgs, lib, ... }:

{
  # https://mynixos.com/home-manager/options/programs.zsh
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    initContent = lib.mkBefore ''
      fpath=("$HOME/.config/zsh/completions" $fpath)
    '';

    autosuggestion.enable = true;
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
    {
      name = "zsh-autosuggestions";
      src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    }
    {
      name = "zsh-completions";
      src = "${pkgs.zsh-completions}/share/zsh-completions";
    }
  ];
}
