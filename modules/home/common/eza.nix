# Modern, maintained replacement for ls

{ ... }:

{
  programs.eza = {
    enable = true;

    # Display icons next to file names (--icons=auto|always|never)
    icons = "never";

    # Use terminal colours in output (--color=auto|always|never).
    colors = "auto";

    # List each file's Git status if tracked or ignored (--git).
    git = true;

    # Not sure what else this does, but if enabled it aliases 'ls=eza' which I
    # don't want.
    enableZshIntegration = false;

    extraOptions = [
      "--group-directories-first"
    ];
  };
}
