{pkgs, ...}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["intel"];
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };
}
