{ inputs, config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.awesome;
in 
{
  options.modules.awesome.enable = mkEnableOption "awesomevm support";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      awesome
      rxvt-unicode
      flameshot
      dunst
      libnotify
      kitty
      playerctl
      pamixer
      dunst
      rofi
      acpi
      xorg.xbacklight
      xorg.xmodmap
      xsecurelock
    ];
  };
}
