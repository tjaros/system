{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    gnomeExtensions.screen-rotate
    gnome.gnome-tweaks
    gnome.zenity
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    xorg.xprop

  ];
  services.udev.packages =  with pkgs; [ gnome.gnome-settings-daemon ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
  
}
