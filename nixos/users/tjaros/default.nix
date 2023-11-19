{ pkgs, lib, config, ... }:

{
  users.users.tjaros = {
    initialPassword = "correcthorsebatterystaple";
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "chipwhisperer" "libvirtd" ];
    shell = pkgs.fish;
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "tjaros";
  };
}
