{ lib, config, ... }:

let
  cfg = config.homebrew;
  isFullyQualified = name: lib.length (lib.splitString "/" name) == 3;
  brewLine = brew:
    ''brew "${brew}"${lib.optionalString (isFullyQualified brew) ", trusted: true"}'';
  caskLine = cask:
    ''cask "${cask}"${lib.optionalString (isFullyQualified cask) ", trusted: true"}'';
in
with lib;
{
  options.homebrew = {
    taps = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };

    brews = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };

    # https://formulae.brew.sh/cask/
    casks = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = {
    home.sessionPath = [ "/opt/homebrew/bin" ];

    homebrew.taps = [
      "d12frosted/emacs-plus"
      "domcyrus/rustnet"                # RustNet

      # "koekeishiya/formulae"
      # "FelixKratz/formulae"           # sketchybar
      # "jackielii/tap"
    ];

    homebrew.brews = [
      "colima"                        # Container runtimes on MacOS
      # TODO The brew version of container is currently broken.
      #"container"                     # Create and run Linux containers using lightweight virtual machines
      "lima"                          # Linux virtual machines
      "lilypond"
      "gcc"                           # GNU Compiler Collection
      "docker"
      "domcyrus/rustnet/rustnet"      # Cross-platform network monitoring tool built with Rust.
      "poppler"                       # PDF rendering library including pdftotext.
      "gemini-cli"

      # ---------------------
      # Programming Languages
      # ---------------------

      "rust"                          # Safe, concurrent, practical language
      "rust-analyzer"                 # LSP for Rust
      "wakeonlan"
      # "docker-compose"
      # "docker-buildx"
      # "lima"                          # Linux virtual machines
      # "sketchybar"                    # Fully configurable status bar
      # "yabai"                         # Tiling window manager
    ];

    # https://formulae.brew.sh/cask/
    homebrew.casks = [
      "alt-tab"                       # Windows alt-tab on macOS
      "codex"
      "chatgpt"
      "claude-code"                   # Terminal-based AI coding assistant
      "crystalfetch"                  # UI for creating Windows installer ISO from UUPDump
      "d12frosted/emacs-plus/emacs-plus-app"
      "karabiner-elements"            # Keyboard customiser
      "keepassxc"                     # Offline password manager
      "linearmouse"                   # Allows trackpad and mouse to have sane scrolling
      "mac-mouse-fix"                 # Mouse utility to add gesture functions and smooth scrolling to 3rd party mice
      "utm"                           # Virtual machines UI using QEMU
      "wezterm"                       # GPU-accelerated cross-platform terminal emulator and multiplexer
      "vlc"
      # "android-file-transfer"         # Transfer files from and to an Android smartphone
      # "balenaetcher"                  # Tool to flash OS images to SD cards & USB drives
      # "blender"                       # 3D creation suite
      # "dbngin"                        # Database version management tool
      # "freecad"                       # 3D parametric modeller
      # "iina"                          # The modern media player for macOS.
      # "inkscape"                      # Vector graphics editor
      # "losslesscut"                   # Trims video and audio files losslessly
      # "maccy"                         # Clipboard manager
      # "monitorcontrol"                # Tool to control external monitor brightness & volume
      # "orcaslicer"                    # G-code generator for 3D printers
      # "podman-desktop"                # Browse, manage, inspect containers and images
      # "zen"                           # Gecko based web browser
    ];

    home.file.".Brewfile" = {
      text =
        (concatMapStringsSep "\n" (tap: ''tap "${tap}"'') cfg.taps)
        + "\n"
        + (concatMapStringsSep "\n" brewLine cfg.brews)
        + "\n"
        + (concatMapStringsSep "\n" caskLine cfg.casks)
        + "\n";
      onChange = ''
        /opt/homebrew/bin/brew bundle install --force-cleanup --no-upgrade --force --global
      '';
    };
  };
}
