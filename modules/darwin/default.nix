{pkgs, ...}: {
  # here go the darwin preferences and config items
  users.users.bradley.home = "/Users/bradley";

  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [
      bash
      zsh
    ];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [
      coreutils
      discord
      jetbrains.clion
      vscode
      spotify
    ];
    systemPath = ["/opt/homebrew/bin" "$HOME/Personal/bin"];
    pathsToLink = ["/Applications"];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = false; # DANGER
  fonts.fonts = [(pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})];
  services.nix-daemon.enable = true;
  system.defaults = {
    # finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    # NSGlobalDomai.AppleShowAllExtensions = true;
    # NSGlobalDomain.InitialKeyRepeat = 14;
    # NSGlobalDomain.KeyRepeat = 1;
  };
  # backwards compat; don't change
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;

    masApps = {};
    casks = ["google-chrome" "linearmouse" "macs-fan-control" "tiles" "quarto"];
    # taps = [ "fujiapple852/trippy" ];
    # brews = [ "llvm" ];
  };
}
