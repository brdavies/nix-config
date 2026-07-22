{ lib, ... }:

{
  # Opengear host-specific SSH config.
  #
  # This module is imported only by hosts/opengear/default.nix, so anything
  # defined here is scoped to that host.
  programs.ssh = {
    settings = {

      # ------------------------------------------------------------------
      # DeskLAN Devices
      # ------------------------------------------------------------------

      "nova" = {
        HostName = "nova";   # or "192.168.98.x"
        User = "root";
        HostKeyAlias = "nova";
        CheckHostIP = "no";
      };

      "desklan" = {
        HostName = "desklan"; # or "192.168.98.x"
        User = "root";
        HostKeyAlias = "desklan";
        CheckHostIP = "no";
      };

      # Any host in the desklan subnet (192.168.98.0/24) or ogdev subnet
      # (192.168.99.0/24) should default to root.
      "192.168.98.* 192.168.99.* ogdev" = {
        User = "root";
      };

      # Engineering team gateways.
      "10.250.20.32 10.250.20.88 10.250.20.80 eng-team xm-team ngcs-team" = {
        User = "bend";
      };

      "oghw-24e-tester3.equip.bne.hw.opengear.com" = lib.hm.dag.entryBefore [ "*.equip.bne.hw.opengear.com" ] {
        User = "user";
        IdentityFile = "~/.ssh/id_dut_shared";
      };

      "*.equip.bne.hw.opengear.com" = {
        User = "root";
        IdentityFile = "~/.ssh/id_dut_shared";
      };

      "192.168.140.*" = {
        User = "root";
        ProxyJump = "hwlab-rack.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };

      "192.168.142.*" = {
        User = "root";
        ProxyJump = "hwlab-bench.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };

      "192.168.143.*" = {
        User = "root";
        ProxyJump = "hwtest-1f1.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };

      "192.168.144.*" = {
        User = "root";
        ProxyJump = "hwtest-1f2.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };

      "192.168.148.*" = {
        User = "root";
        ProxyJump = "hwtest-1r1.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };

      "192.168.149.*" = {
        User = "root";
        ProxyJump = "hwtest-1r2.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };

      "192.168.146.*" = {
        User = "root";
        ProxyJump = "hwtest-2f1.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };

      "192.168.147.*" = {
        User = "root";
        ProxyJump = "hwtest-2f2.equip.bne.hw.opengear.com";
        UserKnownHostsFile = "/dev/null";
        StrictHostKeyChecking = "no";
      };
    };
  };
}
