{ ... }:

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

      "*.equip.bne.hw.opengear.com" = {
        user = "root";
        identityFile = "~/.ssh/id_dut_shared";
      };

      "192.168.140.*" = {
        user = "root";
        proxyJump = "hwlab-rack.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };

      "192.168.142.*" = {
        user = "root";
        proxyJump = "hwlab-bench.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };

      "192.168.143.*" = {
        user = "root";
        proxyJump = "hwtest-1f1.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };

      "192.168.144.*" = {
        user = "root";
        proxyJump = "hwtest-1f2.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };

      "192.168.148.*" = {
        user = "root";
        proxyJump = "hwtest-1r1.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };

      "192.168.149.*" = {
        user = "root";
        proxyJump = "hwtest-1r2.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };

      "192.168.146.*" = {
        user = "root";
        proxyJump = "hwtest-2f1.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };

      "192.168.147.*" = {
        user = "root";
        proxyJump = "hwtest-2f2.equip.bne.hw.opengear.com";
        userKnownHostsFile = "/dev/null";
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };
    };
  };
}
