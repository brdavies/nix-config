{ pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      ".DS_Store"
      ".direnv"
      ".claude"
      "__pycache__"
    ];
    includes = [
      {
        condition = "gitdir:~/ngcs/";
        contents = {
          user.name = "Ben Davies";
          user.email = "ben.davies@digi.com";
          user.signingkey = "~/.ssh/id_ed25519.pub";
        };
      }
    ];

    settings = {
      user.name = "Ben Davies";
      user.email = "brdavies@gmail.com";

      ##############################################################
      # Core
      ##############################################################

      core.sshCommand = lib.mkIf pkgs.stdenv.isDarwin "/usr/bin/ssh";

      core.editor = "emacs -nw";

      # -F • Only use a pager when necessary.
      # -X • Don't clear the screen on exit.
      # -R • Raw ANSI colour sequences.
      # -S • Don't wrap long lines
      # -i • Ignore case when searching.
      core.pager = "less -FXRSi";

      # Markdown is often pasted into changelogs and headings are
      # being interpretted as comments.
      core.commentchar = "%";

      init.defaultBranch = "main";

      # Use columns when output is a TTY.
      column.ui = "auto";

      ##############################################################
      # Aliases
      ##############################################################

      alias = {
        # ----------------
        # Too Lazy To Type
        # ----------------

        br = "branch";
        co = "checkout";

        # ------
        # Status
        # ------

        # -s • Output in short format.
        # -b • Show branch and tracking even in short.
        st = "status -sb";

        # ------------------
        # Changing the State
        # ------------------

        unstage = "reset HEAD --";
        uncommit = "reset --soft HEAD^1";
        amend = "commit --amend --no-edit";


        # Be careful, this removes all unknown files and directories
        # and can't be undone.
        # -i • interactive mode
        # -d • delete directories
        # -f • force, needs to be specified twice.
        purge = "clean -i -ffd";

        # -------------------------------------------
        # Extracting information from commit messages
        # -------------------------------------------

        # Show previous commit message only.
        msg = "log -1 --pretty='%B'";

        # SHA of previous commit only.
        sha = "log -1 --pretty='%H'";

        # Show previous commit message only with SHA appended. This is
        # useful for appending information to the issue tracking
        # system.
        msg-sha = "log -1 --pretty='%Bcommit:%h'";

        # ----------
        # Submodules
        # ----------

        # Get all submodules to their correct commits.
        sup = "submodule update --init --recursive";

        # ----
        # Logs
        # ----

        # Add '-p' to any of these to see what actually changed in
        # each commit.

        # Log master showing only direct commits and merge commits.
        # This is useful to see what issues are present in master.
        #
        # --first-parent • Don't show commits of merged branches.
        # %h  • abbreviated hash
        # %s  • commit message
        # %cr • committer date (relative)
        # %cn • committer name
        # %d  • decorated refs

        # Don't show commits of merged branches (brief).
        lg = "log"
             + " --first-parent"
             + " --format=format:'%C(bold blue)%h%C(reset)'' %C(white)%s%C(reset)''%C(yellow)%d%C(reset)'"
             + " --abbrev-commit"
             + " --date=relative"
             + " --decorate-refs-exclude='tags/*jenkins-build/*'";

        # ----
        # Diff
        # ----

        # Diff using delta
        dd = "-c pager.diff=delta diff";

        # Diff staged (cached).
        ds = "-c pager.diff=delta diff --staged";
        dc = "-c pager.diff=delta diff --staged";

        # Diff HEAD
        dh = "-c pager.diff=delta show --ext-diff";

        # Diff log
        dl = "-c pager.diff=delta lg --ext-diff";

        # ----
        # Refs
        # ----

        # List most recent tags.
        tags = "for-each-ref"
               + " --count=10"
               + " --sort='-*authordate'"
               + " --format='%(refname:short) (%(*authordate))'"
               + " 'refs/tags/*'";

        # List recent branches.
        recent = "for-each-ref"
                 + " --count=10"
                 + " --sort=-committerdate"
                 + " --format='%(refname:short) (%(color:bold green)%(committerdate:relative)%(color:reset))'"
                 + "'refs/heads/*'";
      };

      ##############################################################
      # Diff
      ##############################################################

      difftool.prompt = "false";

      ##############################################################
      # Push and Pull
      ##############################################################

      push.default = "current";
      push.autoSetupRemote = true;
      pull.ff = "only";
      pull.default = "current";
      branch.sort = "-committerdate";
    };
  };
}
