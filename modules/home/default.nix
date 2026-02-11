{ pkgs, ... }:

{
  home.sessionPath = [ "$HOME/.local/bin" ];

  imports = [
    ./common/delta.nix         # A syntax-highlighting pager for git, diff, and grep output
    ./common/emacs.nix
    ./common/eza.nix           # Modern replacement for `ls`
    ./common/gh.nix            # GitHub on the command line
    ./common/git.nix
    ./common/starship.nix      # The minimal, blazing-fast, and infinitely customizable prompt for any shell
    ./common/zsh.nix
  ];

  home.sessionVariables = {
    ERL_AFLAGS = "-kernel shell_history enabled";

    # Some programs expect this to be a single binary without args, so use
    # 'emacs-nw' which is a wrapper around `emacs -nw`.
    EDITOR = "emacs-nw";
    VISUAL = "emacs";
  };

  # Aliases common across all shells.
  home.shellAliases = {
    # "ll" = "ls -alFG";
    # "la" = "ls -AG";
    # "l" = "ls -lhG";
    # "lt" = "tree -dL";

    # -l, --long
    # -b, --binary
    # -h, --header
    #
    #"l" = "eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first";

    # Listing files
    "l" = "eza --long";
    "ll" = "eza --long --all";

    # Sort by modified
    "lm" = "eza --long --sort=modified";
    "llm" = "eza --long --all --sort=modified";

    # List as tree. eza is better at this than 'tree'.
    "lt" = "eza --tree";
    "lt2" = "eza --tree --level 2";
    "lt3" = "eza --tree --level 3";
    "ltd" = "eza --tree --only-dirs";
    "ltd2" = "eza --tree --only-dirs --level 2";
    "ltd3" = "eza --tree --only-dirs --level 3";

    # Too lazy to type 'cd ..'...
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";

    # Change to the current directory. This is useful for staying in a directory
    # that was deleted and recreated (e.g. a build output directory).
    "cdd" = "cd `pwd`";

    "hm.generations" = "nix run home-manager -- generations";

    # Home Manager (hm) aliases
    "hm.build" = "nix run home-manager -- build --flake ~/.config/nix-config#\"$HOME_MANAGER_PROFILE\"";
    "hm.switch" = "nix run home-manager -- switch --flake ~/.config/nix-config#\"$HOME_MANAGER_PROFILE\"";

    "hm.packages" = "nix run home-manager -- packages";
    "hm.rollback" = "nix run home-manager -- switch --rollback";
    "hm.prune" = "nix run home-manager -- expire-generations \"-5 days\"";
  };

  # https://search.nixos.org/packages
  home.packages =
    with pkgs;
    let
      otp = pkgs.beam.packages.erlang_28;
    in
      [
        # ------
        # Shells
        # ------
        bash                   # Bourne-Again SHell, a UNIX command interpreter
        nushell                # Modern shell for the GitHub era
        zsh                    # UNIX shell (command interpreter)

        # --------
        # Terminal
        # --------
        asciinema              # Record and share terminal sessions
        tmux                   # Terminal multiplexer

        # ---------------------------
        # Searching Files and Content
        # ---------------------------
        jq                     # Lightweight and flexible command-line JSON processor
        lemmeknow              # Fastest way to identify anything!
        ripgrep                # Search tool like grep and The Silver Searcher
        silver-searcher        # Code-search similar to ack
        pv                     # Monitoring the progress of data through a pipeline and modifying its flow
        ouch                   # Tool for compressing and decompressing for various formats

        # -----------------
        # Text File Formats
        # -----------------
        glow                   # Markdown • Render markdown on the CLI
        jless                  # JSON • command-line JSON viewer designed for reading, exploring, and searching through JSON data.
        jq                     # JSON • Lightweight and flexible command-line JSON processor
        less

        # ------------------
        # System Monitoring
        # ------------------
        procs                  # Modern replacement for ps written in Rust
        pstree                 # Show ps output as a tree
        htop                   # Improved top (interactive process viewer)
        bottom                 # Yet another cross-platform graphical process/system monitor

        # -----------------------------
        # Files, Directories, and Disks
        # -----------------------------
        dua                    # View disk space usage and delete unwanted data, fast
        dust                   # More intuitive version of du in rust
        fd                     # Simple, fast and user-friendly alternative to find
        rclone                 # Rsync for cloud storage
        tree                   # Display directories as trees (with optional color/HTML output)
        watchexec              # Execute commands when watched files change
        xz                     # General-purpose data compression with high compression ratio
        zlib                   # General-purpose lossless data-compression library

        # --------
        # Database
        # --------
        rainfrog               # Database management TUI for postgres

        # ----------
        # Networking
        # ----------
        curl                   # Get a file from an HTTP, HTTPS or FTP server
        doge                   # Command-line DNS client
        httpie                 # Command line HTTP client whose goal is to make CLI human-friendly
        iperf                  # Tool to measure maximum TCP and UDP bandwidth
        mitmproxy              # Intercept, modify, replay, save HTTP/S traffic
        mtr                    # 'traceroute' and 'ping' in a single tool
        nmap                   # Port scanning utility for large networks
        tldx                   # Domain Availability Research Tool
        unbound                # Validating, recursive, caching DNS resolver
        wget                   # Internet file retriever

        # -----
        # Media
        # -----
        exiftool               # Reading and writing EXIF metadata
        ffmpeg                 # Play, record, convert, and stream select audio and video codecs
        graphviz               # Graph visualization software

        # ---------------------
        # Programming Languages
        # ---------------------
        # awk                  # Text processing scripting language
        # gawk                 # GNU awk utility
        # janet                # Dynamic language and bytecode vm
        # lua                  # Powerful, lightweight programming language
        # luarocks             # Package manager for the Lua programming language
        # nodejs               # Open-source, cross-platform JavaScript runtime environment
        # perl                 # Highly capable, feature-rich programming language
        # python               # Interpreted, interactive, object-oriented shitty programming language

        # -----------
        # Development
        # -----------
        # asdf               # Extendable version manager with support for Ruby, Node.js, Erlang & more
        #autoconf           # Automatic configure script builder
        #clang-format       # Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript
        #coreutils          # GNU File, Shell, and Text utilities
        # direnv             # Load/unload environment variables based on $PWD
        d2                 # Diagram scripting language that turns text to diagrams. It stands for Declarative Diagramming.
        difftastic         #
        git                # Distributed revision control system
        gum                # Tool for glamorous shell scripts
        jj                 # jujutsu Git-compatible distributed version control system
        meson              # Fast and user friendly build system
        mise               # mise is a polyglot tool version maanging, replacing tools like asdf, nvm, pyenv, rbenv, direnv.
        prettier           # Code formatter for JavaScript, CSS, JSON, GraphQL, Markdown, YAML. See also prettierd.
        tealdeer           # Very fast implementation of tldr (Simplified and community-driven man pages)
        tig                # Text interface for Git repositories
        tio                # Simple TTY terminal I/O application
        uv                 # Extremely fast Python package installer and resolver, written in Rust
        #tree-sitter        # Incremental parsing library
        #universal-ctags    # Maintained ctags implementation

        # -------------------
        # LSPs and Formatters
        # -------------------

        # biome                         # Web • Fast formatter for JavaScript, TypeScript, JSX, TSX, JSON, HTML, CSS and GraphQL
        # dockerfile-language-server    # Docker • Language server for Dockerfiles
        # nixd                          # Nix • Feature-rich Nix language server
        # nixfmt                        # Nix • Official formatter for Nix code
        # shellcheck                    # Shell • Shell script analysis tool
        # tailwindcss-language-server   # Web • Tailwind CSS Language Server
        # typescript-language-server    # Web • Language Server Protocol implementation for TypeScript
        # prettierd
        # pyright                       # Python • Type checker for the Python language
        # ruff                          # Python • Extremely fast Python linter and code formatter
        # ty                          # Python • Extremely fast Python type checker and language server, written in Rust
        # rustywind                   # Web • CLI for organizing Tailwind CSS classes
        # shfmt                       # Shell • Shell parser and formatter
        # stylua                      # Lua • Opinionated Lua code formatter
        # superhtml                   # HTML • HTML Language Server and Templating Language Library
        # sql-formatter               # SQL • Whitespace formatter for different query languages
        # taplo                       # TOML • TOML toolkit written in Rust
        # tombi                       # TOML • TOML Formatter / Linter / Language Server
        # yaml-language-server        # YAML • Language Server for YAML Files

        # -----
        # Fonts
        # -----
        fira-code
        iosevka
        monaspace
        nerd-fonts.fira-code
      ];

  programs = {
    # zoxide is a smarter cd command, inspired by z and autojump.
    zoxide = {
      enable = true;
    };

    # Clone of cat(1) with syntax highlighting and Git integration
    bat = {
      enable = true;
      config = {
        theme = "ansi";
        style = "plain";
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batpipe
        batgrep
        batwatch
      ];
    };

    # Navigate directory trees
    broot = {
      enable = true;
      enableZshIntegration = true;
    };

    # Command-line fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  # programs = {

  #   direnv = {
  #     enable = true;
  #     nix-direnv.enable = true;
  #     config.global = {
  #       load_dotenv = true;
  #     };
  #   };



  #   eza = {
  #     enable = true;
  #     icons = "auto";
  #     git = true;
  #     extraOptions = [ "--group-directories-first" ];
  #   };

  #   atuin = {
  #     enable = true;
  #     flags = [ "--disable-up-arrow" ];
  #   };


  # };
}
