{ pkgs, ... }:

{
  home.file.".local/bin/emacs-nw" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      emacs -nw "$@"
    '';
  };
}
