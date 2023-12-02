{ inputs, config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.i3;
in 
{
  options.modules.i3.enable = mkEnableOption "awesomevm support";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      i3-rounded
      rxvt-unicode
      flameshot
      polybarFull
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
