{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    gnomeExtensions.screen-rotate
    gnomeExtensions.gtile
    gnomeExtensions.arcmenu
    gnomeExtensions.tiling-assistant
    gnomeExtensions.battery-time-percentage-compact
    gnomeExtensions.dash-to-panel
    gnomeExtensions.impatience
    gnomeExtensions.hide-clock
    gnomeExtensions.resource-monitor
    gnomeExtensions.workspace-indicator
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
