# Only the settings that differ from macOS defaults.
{
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowScrollBars = "Always";
      "com.apple.keyboard.fnState" = true;
      "com.apple.swipescrolldirection" = false;
    };

    dock = {
      autohide = true;
      magnification = true;
      largesize = 58;
      tilesize = 45;
      show-recents = false;
      wvous-br-corner = 1;
    };

    finder = {
      FXPreferredViewStyle = "clmv";
      FXRemoveOldTrashItems = true;
      ShowMountedServersOnDesktop = true;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
  };
}
