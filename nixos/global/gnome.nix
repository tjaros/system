{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    kitty
    gnomeExtensions.tiling-assistant
    gnome.gnome-tweaks
    gnome.zenity
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    xorg.xprop

  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia" "intel"];
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false;
      desktopManager.gnome.enable = true;
    };
  };
  
}
