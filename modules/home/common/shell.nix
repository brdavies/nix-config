{ ... }:

{
  home.sessionVariables = {
    ERL_AFLAGS = "-kernel shell_history enabled";

    # Some programs expect this to be a single binary without args, so use
    # 'emacs-nw' which is a wrapper around `emacs -nw`.
    EDITOR = "emacs-nw";
    VISUAL = "emacs";

    # Stop Python from sprinkling __pycache__ shit everywhere. Honestly, who
    # thought that was a good idea??
    #
    # Also need to run if you don't want apps like Codex shitting __pycache__
    # everywhere: 'launchctl setenv PYTHONPYCACHEPREFIX "$HOME/.cache/python/pycache"'
    PYTHONPYCACHEPREFIX = "$HOME/.cache/python/pycache";
  };

  # Aliases common across all shells.
  home.shellAliases = {
    # "ll" = "ls -alFG";
    # "la" = "ls -AG";
    # "l" = "ls -lhG";
    # "lt" = "tree -dL";

    # -l, --long
    # -b, --binary
    # -h, --header
    #
    #"l" = "eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first";

    # Listing files
    "l" = "eza --long";
    "ll" = "eza --long --all";

    # Sort by modified
    "lm" = "eza --long --sort=modified";
    "llm" = "eza --long --all --sort=modified";

    # List as tree. eza is better at this than 'tree'.
    "lt" = "eza --tree";
    "lt2" = "eza --tree --level 2";
    "lt3" = "eza --tree --level 3";
    "ltd" = "eza --tree --only-dirs";
    "ltd2" = "eza --tree --only-dirs --level 2";
    "ltd3" = "eza --tree --only-dirs --level 3";

    # Too lazy to type 'cd ..'...
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";

    # Change to the current directory. This is useful for staying in a directory
    # that was deleted and recreated (e.g. a build output directory).
    "cdd" = "cd `pwd`";

    "hm.generations" = "nix run home-manager -- generations";

    # Home Manager (hm) aliases
    "hm.build" = "nix run home-manager -- build --flake ~/.config/nix-config#\"$HOME_MANAGER_PROFILE\"";
    "hm.switch" = "nix run home-manager -- switch --flake ~/.config/nix-config#\"$HOME_MANAGER_PROFILE\"";

    "hm.packages" = "nix run home-manager -- packages";
    "hm.rollback" = "nix run home-manager -- switch --rollback";
    "hm.prune" = "nix run home-manager -- expire-generations \"-5 days\"";

    "hm.update" = "home_manager_update";
  };
}
