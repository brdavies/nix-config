{ lib, ... }:

{
  # Opengear host-specific SSH config.
  #
  # This module is imported only by hosts/opengear/default.nix, so anything
  # defined here is scoped to that host.
  programs.ssh = {
    matchBlocks = {

      # ------------------------------------------------------------------
      # DeskLAN Devices
      # ------------------------------------------------------------------

      "nova" = {
        hostname = "nova";   # or "192.168.98.x"
        user = "root";
        extraOptions = {
          HostKeyAlias = "nova";
          CheckHostIP = "no";
        };
      };

      "desklan" = {
        hostname = "desklan"; # or "192.168.98.x"
        user = "root";
        extraOptions = {
          HostKeyAlias = "desklan";
          CheckHostIP = "no";
        };
      };

      # Any host in the desklan subnet (192.168.98.0/24) or ogdev subnet
      # (192.168.99.0/24) should default to root.
      "192.168.98.* 192.168.99.* ogdev" = {
        user = "root";
      };
    };

    # Appended after shared ssh.nix extraConfig for this host only.
    # Put raw ssh_config directives here when Home Manager doesn't expose
    # a structured option.
    extraConfig = lib.mkAfter ''
    '';
  };
}
