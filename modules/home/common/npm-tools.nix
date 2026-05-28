{ config, lib, pkgs, ... }:

let
  inherit (lib)
    hm
    listToAttrs
    mapAttrsToList
    mkOption
    nameValuePair
    types;

  cfg = config.npmTools;
  installDir = "$HOME/${cfg.directory}";
  packageJson = builtins.toJSON {
    private = true;
    dependencies = listToAttrs (mapAttrsToList (_: tool: nameValuePair tool.package tool.version) cfg.packages);
  };
in
{
  options.npmTools = {
    directory = mkOption {
      type = types.str;
      default = ".local/share/npm-tools";
      description = "Home-relative directory used for declaratively managed npm CLI packages.";
    };

    packages = mkOption {
      default = { };
      description = "npm CLI packages to install into the managed npm tools directory.";
      type = types.attrsOf (types.submodule ({ name, ... }: {
        options = {
          package = mkOption {
            type = types.str;
            default = name;
            description = "npm package name.";
          };

          version = mkOption {
            type = types.str;
            default = "latest";
            description = "npm version or semver range to install.";
          };
        };
      }));
    };
  };

  config = lib.mkIf (cfg.packages != { }) {
    home.packages = [ pkgs.nodejs_24 ];
    home.sessionPath = [ "$HOME/${cfg.directory}/node_modules/.bin" ];

    home.file."${cfg.directory}/package.json".text = packageJson;
    home.file."${cfg.directory}/.npmrc".text = ''
      audit=false
      fund=false
      package-lock=true
      save=false
    '';

    home.activation.installNpmTools = hm.dag.entryAfter [ "writeBoundary" ] ''
      export HOME="${config.home.homeDirectory}"
      export NPM_CONFIG_CACHE="''${XDG_CACHE_HOME:-$HOME/.cache}/npm"

      install_dir="${installDir}"
      mkdir -p "$install_dir"
      cd "$install_dir"

      ${pkgs.nodejs_24}/bin/npm install --omit=dev
    '';
  };
}
