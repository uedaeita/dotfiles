# dotfiles

macOS (Apple Silicon) environment for one Mac, built with Determinate Nix + nix-darwin + home-manager (what gets installed), chezmoi (files under `$HOME`) and mise (language runtimes).

## Layers

| Layer                               | Owner                        | Edit                               |
| ----------------------------------- | ---------------------------- | ---------------------------------- |
| macOS settings and GUI apps (casks) | nix-darwin                   | `nix/darwin/`                      |
| CLI tools                           | home-manager `home.packages` | `nix/home/packages.nix`            |
| Language runtimes (global defaults) | mise                         | `home/dot_config/mise/config.toml` |
| Files under `$HOME`                 | chezmoi                      | `home/`                            |

Rule: Nix decides what is installed, chezmoi decides which files are placed. home-manager `programs.*` and `home.file` are not used.

Projects pin their own runtime versions; the global mise config is only the fallback.

## New Mac

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/uedaeita/dotfiles/main/bootstrap.sh)"
```

Then follow the checklist it prints.

## Daily commands

```sh
sudo darwin-rebuild switch --flake ~/dotfiles       # after editing nix/
chezmoi apply                                       # after editing home/
chezmoi re-add ~/.config/karabiner/karabiner.json   # Karabiner rewrote its config
nix flake update && sudo darwin-rebuild switch --flake ~/dotfiles
```

## Secrets: `~/.zshrc.local`

Never committed. Sourced last by `~/.zshrc` when it exists. Put tokens there:

```sh
export SOME_API_TOKEN=...
```

## Manual installs

- Microsoft Office, VMware Fusion (no cask), e-Gov, ScanSnap, MynaPortal, ABBYY, Tuxera, Okta Verify
- App Store: Xcode, LINE, Display Menu
