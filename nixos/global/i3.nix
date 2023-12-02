{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rxvt-unicode
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
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      videoDrivers = ["nvidia" "intel"];
      windowManager.i3.enable = true;
      displayManager.defaultSession = "xfce";
      layout = "us";
    };
  };
}
