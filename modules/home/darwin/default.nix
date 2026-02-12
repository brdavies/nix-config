{ pkgs, ... }:

{
  imports = [
    ./homebrew.nix
    ./karabiner.nix
    ./ssh.nix
    # ./yabai.nix     # Tiling window manager
    # ./sketchybar    # Fast and powerful status bar replacement
  ];

  # MacOS-specific packages.
  home.packages = with pkgs; [
    terminal-notifier     # Send macOS User Notifications from the command-line
    #mas                   # Command-line interface for the Mac App Store
  ];

  # https://mynixos.com/nix-darwin/options/system.defaults
  targets.darwin.defaults = {
    # `killall Dock` to take effect.
    "com.apple.dock" = {
      autohide = true;
      show-recents = false;
      # I need my downloads in dock...
      # static-only = true;
      wvous-bl-corner = 0;
      wvous-br-corner = 0;
      wvous-tl-corner = 0;
      wvous-tr-corner = 0;


    };

    # There doesn't seem to be a way to map caps lock to command, so this has to
    # be done manually. Disabling this prevents home manager from doing any
    # funny business with mapping.
    system.keyboard.enableKeyMapping = false;

    NSGlobalDomain = {

      # Make scrolling work like it's always done.
      #"com.apple.swipescrolldirection" = true;

      # Controls whether a windows can be dragged by holding a modifier key and
      # dragging anywhere inside the window.
      NSWindowShouldDragOnGesture = true;

      # Controls whether Finder shows all file extensions.
      AppleShowAllExtensions = true;

      # Controls how long macOS waits before a held key starts repeating (lower
      # is faster).
      InitialKeyRepeat = 15;

      # Controls how fast a key repeats after the initial delay when you hold it
      # down (lower is faster).
      KeyRepeat = 2;

      # Controls whether macOS shows the accent popup when you hold down a key.
      # It really makes a mess of repeat rate, so disable it.
      ApplePressAndHoldEnabled = false;
    };
  };

  home.file.".hushlogin".text = "";


  # Fontconfig is the system that discovers fonts, indexes them, matches “give
  # me a sans-serif” to an exact font file, and applies font preferences and
  # fallbacks. Without this the fonts installed with nix won't be visible.
  fonts.fontconfig.enable = true;

  # launchd.agents.load-ssh-keys = {
  #   enable = true;
  #   config = {
  #     UserName = "js";
  #     ProgramArguments = [
  #       "/usr/bin/ssh-add"
  #       "--apple-load-keychain"
  #     ];
  #     RunAtLoad = true;
  #   };
  # };
}
