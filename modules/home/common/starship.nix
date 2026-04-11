# The minimal, blazing-fast, and infinitely customizable prompt for any shell

{ pkgs, lib, ... }:

{
  # https://starship.rs/config/
  programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      # If it can't be done quickly, don't do it. git status on large
      # repositories is the main culprit.
      command_timeout = 100;

      directory = {
        # When inside a repository, don't trucate the path to the name of the
        # repository.
        truncate_to_repo = false;

        # There's plenty of horizontal space, let's use it.
        truncation_length = 0;

        # Still collapse $HOME nicely
        home_symbol = "~";

        truncation_symbol = "…/";

        # Optional but nice: keep the last directory visually distinct
        read_only = " 🔒";
      };

      git_status = {
        # This slows things down pretty bad, especially in big repos like u-boot
        # and linux.
        disabled = true;
      };
    };
  };
}
