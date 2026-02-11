{ lib, ... }:

{
  # # Do NOT install wezterm from nix packages, this is done by homebrew.
  # programs.karabiner.enable = false;

  # Link the repo contents into ~/.config/wezterm
  xdg.configFile."karabiner/karabiner.json".source = ./karabiner/karabiner.json;
}
