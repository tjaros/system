{pkgs, ...}: {
  fonts.fonts = with pkgs; [
    hack-font
    nanum-gothic-coding
    inconsolata
    hasklig
  ];
}
