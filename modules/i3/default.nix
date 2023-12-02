{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.modules.i3;
in 
{
  options.modules.i3.enable = mkEnableOption "Enable AwesomeWM desktop";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      i3-rounded
      rxvt-unicode
      kitty
      playerctl
      pamixer
      dunst
      rofi
      nitrogen
      acpi
      xorg.xbacklight
      xorg.xmodmap
    ];
  };
}
