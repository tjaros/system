{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    kitty
    gnome.gnome-tweaks
    gnome.zenity
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
