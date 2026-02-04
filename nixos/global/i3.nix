{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    st
    zenity
    btop
    networkmanager-openvpn
    xorg.xrandr
    vulkan-tools
    mesa-demos
  ];

  services.picom  = {
    enable = true;
    backend = "glx";
  };

  services.xserver = {
    enable = true;

    videoDrivers = [ "intel"  "amdgpu" ];

    displayManager.lightdm.enable = true;

    windowManager.i3 = {
      enable = true;
    };

    xkb = {
      layout = "us";
      variant = "dvorak";
    };
  };
}

