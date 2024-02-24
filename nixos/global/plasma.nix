{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    xorg.xprop

  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };
  
}
