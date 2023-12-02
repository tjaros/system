{ config, pkgs, lib, ... }:

let
  cfg = config.modules.awesome;
in 
{
  options.modules.awesome.enable = mkEnableOption "Enable AwesomeWM desktop";

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
