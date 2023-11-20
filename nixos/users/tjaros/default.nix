{ pkgs, lib, config, ... }:

{
  users.users.tjaros = {
    initialPassword = "correcthorsebatterystaple";
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "chipwhisperer" "libvirtd" ];
    shell = pkgs.zsh;
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "tjaros";
  };
}
