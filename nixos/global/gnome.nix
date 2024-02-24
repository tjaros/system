{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    unstable.gnomeExtensions.screen-rotate
    unstable.gnomeExtensions.arcmenu
    unstable.gnomeExtensions.tiling-assistant
    unstable.gnomeExtensions.battery-time-percentage-compact
    unstable.gnomeExtensions.dash-to-panel
    unstable.gnomeExtensions.impatience
    unstable.gnomeExtensions.hide-clock
    unstable.gnomeExtensions.resource-monitor
    unstable.gnomeExtensions.workspace-indicator
    unstable.gnome.gnome-tweaks
    unstable.gnome.zenity
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    xorg.xprop

  ];
  services.udev.packages =  with pkgs; [ unstable.gnome.gnome-settings-daemon ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
  
}
