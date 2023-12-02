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
      windowManager.i3.enable = true;
      displayManager.lightdm.enable = true;
    };
  };
  
}
