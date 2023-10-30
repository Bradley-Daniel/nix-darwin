{pkgs, ...}: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
    alejandra
    neofetch

    neovim
    htop
    nodejs
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
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
    extraConfig = ''
      set -g mouse on

      # unbind C-b
      # set -g prefix C-Space
      # bind C-Space send-prefix
      bind r source-file ~/.config/tmux/tmux.conf

      set-option -ga terminal-overrides ",xterm-256color:Tc"
      # set-option -sa terminal-features ',:RGB'
      # set -g default-terminal "screen-256color"


      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Start windows and panes at 1, not 0
      # set -g base-index 1
      # set -g pane-base-index 1
      # set-window-option -g pane-base-index 1
      # set-option -g renumber-windows on

      set-window-option -g mode-keys vi

      # keybindings
      set -g set-clipboard on
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.sensible
      {
        plugin =
          (pkgs.tmuxPlugins.catppuccin.overrideAttrs
          (_: {
            src = pkgs.fetchFromGitHub {
              owner = "Bradley-Daniel";
              repo = "catppuccin-tmux";
              rev = "b6a9b36f1f2afb40478e8f98ac3af7aefa869e64";
              sha256 = "sha256-e/2IvlUbKzjEbnK1WqhzEu1PMDPfQ+X/MBEcDX15FnU=";
            };
         }));
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha' # or frappe, macchiato, mocha
        '';
      }
    ];
  };

  programs.zsh = {
    enable = true;
    envExtra = ''
      DISABLE_MAGIC_FUNCTIONS=true
      # printf '\e[5 q'
    '';
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
        size = 14;
        normal.family = "JetBrainsMono Nerd Font";
      };
      window = {
        padding = {
          x = 10;
          y = 0;
        };
        # decorations = "none";
        decorations = "buttonless";
        dynamic_padding = true;
      };
      cursor = {
        style = {
          # shape = "Beam";
          shape = "Block";
          blinking = "Always";
        };
        blink_interval = 450;
      };
    };
  };
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
