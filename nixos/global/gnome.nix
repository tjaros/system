{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    st
    gnomeExtensions.screen-rotate
    gnome.gnome-tweaks
    gnomeExtensions.pop-shell
    gnome.zenity
    gnome.networkmanager-openvpn
    xorg.xhost
    xorg.xmodmap
    xorg.xev
    xorg.xprop
  ];

  programs.seahorse.enable = true;

  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

  security.pam.services.gdm.enableGnomeKeyring = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
      displayManager.gdm = {
        enable = true;
      };
      desktopManager.gnome.enable = true;
      xkb.layout = "us";
      xkb.variant = "dvorak";
    };
  };
}
