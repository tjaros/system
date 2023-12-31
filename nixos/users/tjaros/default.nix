{ pkgs, lib, config, ... }:

{
  users.users.tjaros = {
    initialPassword = "correcthorsebatterystaple";
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "chipwhisperer" "libvirtd" "dialout" ];
    shell = pkgs.fish;
  };

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "tjaros";
}
