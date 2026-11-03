#!/usr/bin/env bash
# Rebuild from scratch. Safe to re-run: every step checks before acting.
set -euo pipefail

readonly HOST="pollock"
readonly DOTFILES_DIR="$HOME/dotfiles"
readonly DOTFILES_URL="https://github.com/uedaeita/dotfiles.git"
readonly NIX_DAEMON_PROFILE="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"

step() { printf '\n==> %s\n' "$*"; }

ensure_xcode_clt() {
  step "Xcode Command Line Tools"
  if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install
    echo "Finish the Command Line Tools installer, then run this script again."
    exit 1
  fi
}

ensure_homebrew() {
  step "Homebrew"
  if [[ ! -x /opt/homebrew/bin/brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

ensure_nix() {
  step "Determinate Nix"
  if [[ ! -e "$NIX_DAEMON_PROFILE" ]]; then
    curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm --diagnostic-endpoint=""
  fi
  # shellcheck source=/dev/null
  source "$NIX_DAEMON_PROFILE"
}

clone_if_missing() {
  local url="$1" dir="$2"
  if [[ ! -d "$dir/.git" ]]; then
    mkdir -p "$(dirname "$dir")"
    git clone "$url" "$dir"
  fi
}

clone_repos() {
  step "Repositories"
  clone_if_missing "$DOTFILES_URL" "$DOTFILES_DIR"
}

# nix-darwin refuses to overwrite these (nix.custom.conf comes from the Determinate installer); the originals are kept next to them.
move_etc_shell_files() {
  step "/etc files managed by nix-darwin"
  local f
  for f in /etc/zshrc /etc/bashrc /etc/zshenv /etc/nix/nix.custom.conf; do
    if [[ -f "$f" && ! -L "$f" ]]; then
      sudo mv "$f" "$f.before-nix-darwin"
    fi
  done
}

switch_darwin() {
  step "nix-darwin switch"
  sudo nix run nix-darwin -- switch --flake "$DOTFILES_DIR#$HOST"
  # Later steps (chezmoi, its mise script) need the freshly linked user profile.
  export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
}

apply_chezmoi() {
  step "chezmoi apply"
  local config="$HOME/.config/chezmoi/chezmoi.toml"
  if [[ ! -f "$config" ]]; then
    mkdir -p "$(dirname "$config")"
    printf 'sourceDir = "%s"\n' "$DOTFILES_DIR" >"$config"
  fi
  chezmoi apply
}

print_manual_steps() {
  step "Manual steps left"
  cat <<'MSG'
- Create ~/.zshrc.local with the secrets (see README).
- Install the apps without a cask (see README "Manual installs").
- Sign in to apps; run `gh auth login` and `gcloud auth login`.
MSG
}

main() {
  ensure_xcode_clt
  ensure_homebrew
  ensure_nix
  clone_repos
  move_etc_shell_files
  switch_darwin
  apply_chezmoi
  print_manual_steps
}

main "$@"
