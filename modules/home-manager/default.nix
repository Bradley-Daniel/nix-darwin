{pkgs, ...}: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.eza.enable = true;
  programs.git.enable = true;
  # programs.zsh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    # syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "exa --icons";
      nixswitch = "darwin-rebuild switch --flake ~/Personal/dotconfig/darwin .#";
      nixup = "pushd ~/Personal/dotconfig/system-config; nix flake update; nixswitch; popd";
      config = "cd ~/Personal/dotconfig";
      psource = "source $(poetry env info --path)/bin/activate";
      vim = "nvim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  # home.file."Personal/dotconfig/zsh".source = ./file/zsh/source;
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  # programs.kitty = {
  #   enable = true;
  #   font = {
  #     size = 14;
  #     name = "JetBrainsMono Nerd Font";
  #   };
  #   theme = "Catppuccin-Frappe";
  # };
  # home.file.".inputrc".source = ./dotfiles/inputrc;
}
