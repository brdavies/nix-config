# A syntax-highlighting pager for git, diff, and grep output
#
# https://dandavison.github.io/delta/

{ config, lib, pkgs, ... }:

{
  programs.delta = {
    enable = true;

    # This option switches core.pager to delta. Rather
    enableGitIntegration = false;

    options = {
      # This changes foreground text only.
      syntax-theme = "Nord";

      # This will stomp over transparency if the terminal is configured for it.
      background-color = "#2E3440";

      # Added lines — cool green tint, barely above background
      plus-style = "syntax #2F3B33";
      plus-emph-style = "syntax #3B4F42";

      # Removed lines — cool red tint, barely above background
      minus-style = "syntax #3B2F33";
      minus-emph-style = "syntax #4F3B42";

      line-numbers-left-style  = "#4C566A";
      line-numbers-right-style = "#4C566A";
      line-numbers-minus-style = "#BF616A";
      line-numbers-plus-style  = "#A3BE8C";

      hunk-header-style = "syntax italic";
      file-style = "bold";

      keep-plus-minus-markers = true;
      line-numbers = true;
    };
  };
}
