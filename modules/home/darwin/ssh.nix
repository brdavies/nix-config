{ config, lib, pkgs, ... }:

{
  # Use `ssh-add --apple-use-keychain ~/.ssh/id_ed25519` to add a key to the
  # keychain.
  programs.ssh = {
    # Enable Home Manager management of SSH client configuration
    # This generates ~/.ssh/config from Nix
    enable = true;

    # Disable Home Manager’s built-in “default SSH config” (these defaults will
    # be removed in the future anyway). Once disabled, ONLY what is defined in
    # matchBlocks and extraConfig will appear in ~/.ssh/config.
    enableDefaultConfig = false;

    # Match block applied to ALL SSH hosts ("*") This is where we explicitly
    # define our global defaults.
    matchBlocks."*" = {
      # Do NOT forward local SSH agent to remote machines. This is more secure
      # and avoids accidentally leaking credentials.
      forwardAgent = false;

      # Send a keepalive packet every 60 seconds. Prevents idle SSH connections
      # from silently timing out.
      serverAliveInterval = 60;

      # If 3 keepalive packets fail, consider the connection dead. This ensures
      # hung connections terminate instead of freezing forever.
      serverAliveCountMax = 3;

      # Store hashed hostnames in ~/.ssh/known_hosts. Protects your SSH history
      # if known_hosts is ever exposed.
      hashKnownHosts = true;

      # Automatically add private keys to the running ssh-agent the first time
      # they are used. On macOS, this works together with the Keychain.
      addKeysToAgent = "yes";
    };

    # Extra raw SSH config appended verbatim. macOS-specific: tells OpenSSH to
    # integrate with the system Keychain so passphrases are stored securely and
    # reused automatically.
    extraConfig = ''
      UseKeychain yes
    '';
  };

  # Disable Home Manager’s own ssh-agent service. macOS already provides an
  # ssh-agent via launchd with Keychain support. Running two agents causes
  # confusion and broken SSH_AUTH_SOCK behavior.
  services.ssh-agent.enable = false;
}
