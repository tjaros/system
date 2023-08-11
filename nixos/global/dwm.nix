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
  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      windowManager.sddm.enable = true;
      displayManager.lightdm.enable = true;
      layout = "us";
    };
  };
}
