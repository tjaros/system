{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    st
    kitty
    dunst
    pamixer
    libnotify
    rofi
    xorg.xbacklight
  ];

  services = {
    xserver = {
      enable = true;
      windowManager.dwm.enable = true;
      displayManager.lightdm.enable = true;
      layout = "us";
      xkbVariant = "dvorak";
    };
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}