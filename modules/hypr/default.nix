{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hypr;

in {
  options.modules.hypr= { enable = mkEnableOption "hypr"; };
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        wofi
        wl-clipboard
        hyprland
        hyprpaper
      ];

      home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
      
      home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;

      home.file.".config/hypr/start.sh" = {
        source = ./start.sh;
        executable = true;
      };
  };
}
