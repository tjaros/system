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
      videoDrivers = ["intel"];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
  
}
