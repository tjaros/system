{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Mononoki" "Iosevka" ];})
    hack-font
    nanum-gothic-coding
    inconsolata
    hasklig
  ];
}
