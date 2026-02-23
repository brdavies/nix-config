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

        trusted_config_paths = [ "~/src" ];
        env_file = ".env";
        python.uv_venv_auto = true;
      };

      # Run `mise install` after changes are made to this configuration.
      tools = {
        python = "3";

        # This is needed for ansible and anything installed by pip.
        pipx = "latest";

        # pre-commit is a framework to run hooks written in many languages, and
        # it manages the language toolchain and dependencies for running the
        # hooks. prek is a reimagined version of pre-commit, built in Rust. It
        # is designed to be a faster, dependency-free and drop-in alternative
        # for it, while also providing some additional long-requested features.
        prek = "latest";

        # Ansible is an open-source, agentless IT automation engine used for
        # configuration management, application deployment, cloud provisioning,
        # and orchestration.
        ansible = "latest";

        # Extremely fast Python package installer and resolver, written in Rust
        uv = "latest";
      };
    };
  };
}
