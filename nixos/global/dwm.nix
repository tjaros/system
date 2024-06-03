{pkgs, ...}: {
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
    xorg.xhost
    xorg.xev
    xorg.xprop
  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
      windowManager.dwm.enable = true;
      displayManager.sddm.enable = true;
      layout = "us";
    };
  };
}
