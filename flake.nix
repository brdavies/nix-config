{
  description = "my systems :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = host:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              # nixpkgs.overlays = [ (import ./overlays.nix) ];
            }

            ./hosts/${host}
          ];
        };
    in
    {
      # Standalone home-manager (macOS)
      homeConfigurations = {
        "ben@dubbies" = mkHome "dubbies";
        "ben@opengear" = mkHome "opengear";
      };
    };
}
