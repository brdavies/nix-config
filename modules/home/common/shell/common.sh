#!/usr/bin/env sh

# Update all packages managed by home manager.
home_manager_update()
{
    echo "==> Nix: updating channels / flake + switching..."
    nix flake update --flake ~/.config/nix-config
    nix run home-manager -- switch --flake ~/.config/nix-config#\"$HOME_MANAGER_PROFILE\"

    echo "==> Homebrew: updating..."
    if command -v brew >/dev/null 2>&1; then
        brew update
        brew upgrade
        brew cleanup
        echo "done"
    else
        echo "!! brew not found; skipping"
    fi

    echo "==> Done."
}
