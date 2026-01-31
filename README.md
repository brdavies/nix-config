# System Configuration with Nix

Nix is a powerful package manager for Linux and Unix systems that ensures
reproducible, declarative, and reliable software management.

This repository contains configuration for a general-purpose development
environment that runs Nix on macOS, NixOS, or both simultaneously.

https://zero-to-nix.com/start/

https://determinate.systems/blog/nix-direnv/

``` shell
nix run .#build

nix run .#build-switch
```

To try a package:

``` shell
nix shell nixpgks#hello
```
