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

  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia" "intel"];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
  
}
