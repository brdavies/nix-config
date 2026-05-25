{ ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
      user = {
        name = "Ben Davies";
        email = "brdavies@gmail.com";
      };

      "--scope" = [
        {
          "--when".repositories = [
            "/Volumes/work/"
          ];
          user = {
            name = "Ben Davies";
            email = "ben.davies@digi.com";
          };
          signing.key = "~/.ssh/id_ed25519.pub";
        }
      ];

      ui = {
        editor = "emacs -nw";
        pager = [
          "delta"
          "--pager"
          "less -FXRSi"
        ];
        diff-formatter = ":git";
        default-command = [
          "log"
          "--limit"
          "6"
        ];
      };
      aliases = {
        init = [
          "git"
          "init"
          "--colocate"
        ];
        clone = [
          "git"
          "clone"
          "--colocate"
        ];

        # ----------------
        # Too Lazy To Type
        # ----------------

        br = [ "bookmark" ];
        co = [ "edit" ];

        # ------
        # Status
        # ------

        st = [ "status" ];

        # -------------------------------------------
        # Extracting information from commit messages
        # -------------------------------------------

        msg = [
          "log"
          "-r"
          "@"
          "--no-graph"
          "-T"
          "description ++ \"\\n\""
        ];

        sha = [
          "log"
          "-r"
          "@"
          "--no-graph"
          "-T"
          "commit_id ++ \"\\n\""
        ];

        msg-sha = [
          "log"
          "-r"
          "@"
          "--no-graph"
          "-T"
          "description ++ \"commit:\" ++ commit_id.short() ++ \"\\n\""
        ];

        # ----
        # Logs
        # ----

        lg = [
          "log"
          "--limit"
          "10"
        ];

        # ----
        # Diff
        # ----

        dd = [ "diff" ];
        dh = [ "show" ];
        dl = [
          "log"
          "--patch"
        ];

        # ----
        # Refs
        # ----

        tags = [
          "tag"
          "list"
          "--sort"
          "committer-date-"
        ];

        recent = [
          "bookmark"
          "list"
          "--sort"
          "committer-date-"
        ];

        # ------
        # Git
        # ------

        gf = [
          "git"
          "fetch"
        ];

        gp = [
          "git"
          "push"
        ];
      };
    };
  };
}
