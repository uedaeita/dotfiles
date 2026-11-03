{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core
    git
    gh
    jq
    direnv

    # GNU userland; unprefixed names shadow the BSD tools via PATH order
    coreutils
    gnused
    gnugrep
    findutils
    gawk

    # Dev and infra
    d2
    awscli2
    protobuf
    clang-tools
    uv
    redis
    iperf3
    atlas
    stripe-cli

    # Environment managers
    mise
    chezmoi
    rustup

    # Shell
    starship
    fzf
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting

    # Repo checks
    gitleaks
    shellcheck
  ];
}
