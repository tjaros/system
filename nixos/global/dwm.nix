{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    st
    kitty
    dunst
    pamixer
    libnotify
    rofi
    nitrogen
    acpi
    xorg.xbacklight
    xorg.xmodmap
  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia" "intel"];
      windowManager.dwm.enable = true;
      displayManager.sddm.enable = true;
      layout = "us";
    };
  };
}
