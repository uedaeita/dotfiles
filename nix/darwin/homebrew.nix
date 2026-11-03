{
  homebrew = {
    enable = true;
    onActivation = {
      # Apps missing from this list are left alone rather than uninstalled.
      cleanup = "none";
      autoUpdate = false;
      upgrade = false;
    };

    # nixpkgs `ansible` is ansible-core only; the brew formula bundles the community collections.
    brews = [ "ansible" ];

    casks = [
      # CLI and dev tooling
      "gcloud-cli"
      "codex"
      "hashicorp-vagrant"
      "vagrant-vmware-utility"
      "ngrok"
      "orbstack"
      "tableplus"
      "wireshark-app"

      # Editors and terminals
      "cursor"
      "warp"

      # Browsers
      "arc"
      "google-chrome"

      # Communication
      "slack"
      "zoom"
      "microsoft-teams"
      "chatgpt"

      # Utilities
      "clipy"
      "gifox"
      "karabiner-elements"
      "nordvpn"
      "pdf-expert"
      "raycast"
      "rectangle"
      "spotify"
    ];
  };
}
