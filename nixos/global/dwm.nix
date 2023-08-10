{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    st
    kitty
    dunst
    pamixer
    libnotify
    rofi
    dwmbar
    xorg.xbacklight
  ];

  services = {
    xserver = {
      enable = true;
      windowManager.dwm.enable = true;
      displayManager.lightdm.enable = true;
      layout = "us";
    };
  };
}