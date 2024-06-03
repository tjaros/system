{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.tmux;
in {
  options.modules.tmux.enable = mkEnableOption "tmux";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
      ];
      extraConfig = ''
        # Shift alt vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window
        # Set prefix
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix
        # Enable mouse support
        set -g mouse on
        # Start window numbering at 1
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on
        # Open panes in the current directory
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
      '';
    };
  };
}
