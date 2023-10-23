{pkgs, ...}: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
    cmake
    alejandra
    poetry
    python311
    cmake
    neofetch
    htop
    neovim
    tree-sitter
    nodejs
    black
    ncurses
    rustup
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

  programs.tmux = {
    enable = true;

    baseIndex = 1;

    prefix = "C-Space";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.sensible
      (pkgs.tmuxPlugins.catppuccin.overrideAttrs
        (_: {
          src = pkgs.fetchFromGitHub {
            owner = "Bradley-Daniel";
            repo = "catppuccin-tmux";
            rev = "a93a0b469c485c8768b3f37089fb2da4616c321a";
            sha256 = "sha256-ZrvUq0jwxgxMiS92HpXqnABRpCfYuQTZ6bQr+xbXdkY";
          };
        }))
    ];
    extraConfig = ''
      set -g mouse on

      # unbind C-b
      # set -g prefix C-Space
      # bind C-Space send-prefix

      bind r source-file ~/.config/tmux/tmux.conf

      set-option -sa terminal-features ',XXX:RGB'

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-window-option -g mode-keys vi

      set -g @catppuccin_flavour 'frappe'

      # keybindings
      set -g set-clipboard on
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "exa --icons";
      nixswitch = "darwin-rebuild switch --flake ~/Personal/dotconfig/darwin/.#";
      nixup = "pushd ~/Personal/dotconfig/system-config; nix flake update; nixswitch; popd";
      config = "cd ~/Personal/dotconfig";
      psource = "source $(poetry env info --path)/bin/activate";
      vim = "nvim";
    };
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      GIT_EDITOR = "nvim";
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

  home.file.".config/alacritty/catppuccin.yml".source = ./themes/catppuccin.yml;
  programs.alacritty = {
    enable = true;
    settings = {
      import = ["~/.config/alacritty/catppuccin.yml"];
      font = {
        size = 17;
        normal.family = "JetBrainsMono Nerd Font";
      };
      window = {
        padding = {
          x = 0;
          y = 0;
        };
        decorations = "none";
        dynamic_padding = true;
      };
    };
  };
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
