{ pkgs, ... }:

{
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];

  imports = [
    ./common/delta.nix         # A syntax-highlighting pager for git, diff, and grep output
    ./common/emacs.nix
    ./common/eza.nix           # Modern replacement for `ls`
    ./common/gh.nix            # GitHub on the command line
    ./common/git.nix
    ./common/jujutsu.nix       # jujutsu Git-compatible distributed version control system
    ./common/mise.nix          # Mise is a polyglot tool version maanging, replacing tools like asdf, nvm, pyenv, rbenv, direnv.
    ./common/npm-tools.nix
    ./common/starship.nix      # The minimal, blazing-fast, and infinitely customizable prompt for any shell
    ./common/shell.nix         # Common to all shells.
    ./common/zsh.nix
  ];

  npmTools = {
    packages = {
      mdbook-mcp-server = {
        version = "latest";
      };
    };
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
        jc                     # JSON • serializes the output of popular command line tools and filetypes to structured JSON output
        jq                     # JSON • Lightweight and flexible command-line JSON processor
        less
        minijinja              # Jinja2 • Command Line Utility to render MiniJinja/Jinja2 templates
        qsv                    # CSV •  querying, slicing, sorting, analyzing, filtering, enriching, transforming, validating, joining, formatting, converting tabular data
        yq                     # YAML • Process YAML, JSON, XML, CSV and properties documents from the CLI

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
        imagemagick            # Software suite to create, edit, compose, or convert bitmap images
        ocamlPackages.cpdf     # PDF Command Line Tools

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
        bear               # Generate compile_commands.json by intercepting build commands
        d2                 # Diagram scripting language that turns text to diagrams. It stands for Declarative Diagramming.
        difftastic         #
        git                # Distributed revision control system
        gum                # Tool for glamorous shell scripts
        #jj                 # jujutsu Git-compatible distributed version control system
        meson              # Fast and user friendly build system
        mermaid-cli        # Generation of diagrams from text in a similar manner as markdown
        prettier           # Code formatter for JavaScript, CSS, JSON, GraphQL, Markdown, YAML. See also prettierd.
        tealdeer           # Very fast implementation of tldr (Simplified and community-driven man pages)
        tig                # Text interface for Git repositories
        tio                # Simple TTY terminal I/O application
        #tree-sitter        # Incremental parsing library
        #universal-ctags    # Maintained ctags implementation

        # -------------------
        # LSPs and Formatters
        # -------------------

        # biome                         # Web • Fast formatter for JavaScript, TypeScript, JSX, TSX, JSON, HTML, CSS and GraphQL
        clang-tools                    # C/C++ • clangd and related tooling
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
