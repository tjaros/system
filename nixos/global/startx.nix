{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    rxvt-unicode
    
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    xorg.xprop
  ];

  services = {
    xserver = {
      enable = true;
      autorun = false;
      videoDrivers = ["nvidia" "intel"];
      displayManager.startx.enable = true;
    };
  };
  
}
