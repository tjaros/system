{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    xorg.xprop
  ];

  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
      displayManager.sddm = {
        enable = true;
      };
      desktopManager.plasma6.enable = true;
      xkb.layout = "us";
      xkb.variant = "dvorak";
    };
  };
}
