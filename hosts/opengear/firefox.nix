{ ... }:

{
  programs.firefox = {
    # Firefox is installed via brew, not home manager.
    enable = false;

    policies = {
      EnterpriseRoots = {
        # Trust the operating system’s certificate authority store, so
        # certificates trusted by macOS are also trusted by Firefox.
        Enabled = true;
      };
    };
  };
}
