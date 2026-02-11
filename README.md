# .nix Configuration

My personal macOS and NixOS config. Currently there are two clients:

* `ben@dubbies` • A personal MacOS laptop
* `ben@opengear` • A work MacOS laptop

## Install steps

### macOS (dubbies)

1. Log into the App store.

2. Install nix using the [Determinate Nix Installer][].

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
> Restart the shell after installation

3. Add nix-community cache

```sh
echo "trusted-users = root ben" | sudo tee -a /etc/nix/nix.custom.conf && sudo pkill nix-daemon
nix run nixpkgs#cachix -- use nix-community
```

4. Install homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Disable analytics
/opt/homebrew/bin/brew analytics off
```

5. Clone config

```sh
git clone git@github.com:brdavies/nix-config.git
```

6. Symlink config

```sh
mkdir ~/.config
ln -s (pwd)/nix-config ~/.config/home-manager
```

7. Activate config

```sh
nix run home-manager -- switch
nix run home-manager -- switch --flake ~/.config/nix-config#"ben@dubbies"
```

## Apply new config

Update the configuration and then:

```sh
hm.switch    # Shell alias is defined in shell configuration.
```

## Update packages

```sh
nix flake update
hm.switch
```

```sh
brew update
brew upgrade
```

## Troubleshooting

### Too many open files (macOS)

```sh
sudo launchctl limit maxfiles 1024 unlimited
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon
```

Then retry your build command.

[Determinate Nix Installer]: https://github.com/DeterminateSystems/nix-installer
