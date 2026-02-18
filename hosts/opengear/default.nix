{ config, lib, pkgs, ... }:

{
  home = {
    username = "ben";
    homeDirectory = "/Users/ben";
    stateVersion = "23.05";
  };

  home.sessionVariables = {
    # This is used in nix home manager shell aliases.
    HOME_MANAGER_PROFILE = "ben@opengear";
  };

  # Aliases common across all shells.
  home.shellAliases = {

    # Global Protect, everyone's friend. Easily enable/disable it.
    "gp.disable" = "launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*";
    "gp.enable" = "launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*";
  };

  # Source `~/work/src/ngcs-env/scripts/ngcs.plugin.zsh` if it exists, adding
  # some helpers for NGCS development.
  programs.zsh.initContent = lib.mkIf config.programs.zsh.enable (lib.mkAfter ''
    # Functions and helpers for NGCS.
    ngcs_plugin="$HOME/work/src/ngcs-env/scripts/ngcs.plugin.zsh"
    [[ -r "$ngcs_plugin" ]] && source "$ngcs_plugin"
  '');

  programs.home-manager.enable = true;

  imports = map (x: ../.. + x) [
    /modules/home
    /modules/home/darwin
    /hosts/opengear/ssh.nix
    /hosts/opengear/firefox.nix
    /hosts/opengear/finder.nix
  ];

  # Homebrew additions specific to Opengear
  homebrew = {
    taps = lib.mkAfter [
    ];
    brews = lib.mkAfter [
      "step"                          # Crypto and x509 Swiss-Army-Knife
      "telnet"                        # User interface to the TELNET protocol
    ];
    casks = lib.mkAfter [
      "slack"
      "wireshark-app"
    ];
  };

  # The opengear/tap needs authenticated access which is configured using `gh
  # auth`. The token is (likely) in the macos keychain which brew probably can't
  # read, so it needs to be passed in via an environmental variable.
  #
  # Generate a secondary Brewfile only when GitHub HTTPS auth is available.
  home.activation.opengearTapBrewfile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    brewfile="$HOME/.Brewfile.opengear-tap"
    gh_bin="${pkgs.gh}/bin/gh"

    if [ -x "$gh_bin" ] && [ "$("$gh_bin" config get git_protocol -h github.com 2>/dev/null)" = "https" ]; then
      cat > "$brewfile" <<'EOF'
tap "opengear/tap"
cask "opengear/tap/ydev"
EOF
      HOMEBREW_GITHUB_API_TOKEN="$($gh_bin auth token)" \
        /opt/homebrew/bin/brew bundle --no-upgrade --force --file "$brewfile"
    else
      echo "NOTE brew needs github authentication for opengear/tap. Run:"
      echo ">> gh auth login --hostname github.com --git-protocol https"
      rm -f "$brewfile"
    fi
  '';
}
