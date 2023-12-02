{ config, pkgs, lib, ... }:

{
  
  environment.systemPackages = with pkgs; [
    kitty
    dunst
    pamixer
    libnotify
    rofi
    nitrogen
    acpi
    xorg.xbacklight
    xorg.xmodmap
  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      
      displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
      };
  
      services.xserver.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
        ];
      };
    };
  };
}
