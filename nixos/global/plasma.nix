
{
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["modesetting"];
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      layout = "us";
      xkbVariant = "dvorak";
    };
  };

  services.xserver.desktopManager.plasma5.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}
