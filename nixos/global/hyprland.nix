{
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}