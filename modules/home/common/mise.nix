{ pkgs, lib, ... }:

{
  # https://mynixos.com/home-manager/options/programs.mise
  # https://mise.jdx.dev/
  #
  programs.mise = {
    enable = true;

    # When enabled, Home Manager adds the necessary initialization code to
    # .zshrc. This ensures:
    # - Automatically load tool versions from .mise.toml / .tool-versions
	  # - Adjust PATH dynamically when you cd into projects
	  # - Activate shims for languages like node, python, ruby, etc.
	  # - Ensure mise works seamlessly in interactive shells
    enableZshIntegration = true;


    globalConfig = {

      # https://mise.jdx.dev/configuration/settings.html
      settings = {
        # Controls what mise does when you run a command for a tool that is not
        # currently installed.
        not_found_auto_install = true;

        # Should mise keep downloaded files after installation
        always_keep_download = false;
      };

      # Run `mise install` after changes are made to this configuration.
      tools = {
        python = "3";

        prek = "latest";
      };
    };
  };
}
