{
  imports = [
    ./homebrew.nix
    ./defaults.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Determinate Nixd manages the Nix installation; its module turns off nix-darwin's own Nix management.
  determinateNix.enable = true;

  # ~/.zshrc sources the plugins from /etc/profiles/per-user/$USER/share, which only links listed paths.
  environment.pathsToLink = [
    "/share/zsh-autosuggestions"
    "/share/zsh-syntax-highlighting"
  ];

  networking = {
    computerName = "pollock";
    hostName = "pollock";
    localHostName = "pollock";
  };

  system.primaryUser = "uedaeita";
  users.users.uedaeita.home = "/Users/uedaeita";

  system.stateVersion = 6;
}
