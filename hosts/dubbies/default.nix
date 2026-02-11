{ lib, ... }:

{
  home = {
    username = "ben";
    homeDirectory = "/Users/ben";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  home.sessionVariables = {
    # This is used in nix home manager shell aliases.
    HOME_MANAGER_PROFILE = "ben@dubbies";
  };

  imports = map (x: ../.. + x) [
    /modules/home
    /modules/home/darwin
  ];

  # Homebrew additions specific to my personal laptop.
  homebrew = {
    taps = lib.mkAfter [
    ];
    brews = lib.mkAfter [
    ];
    casks = lib.mkAfter [
    ];
  };
}
