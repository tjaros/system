{ pkgs, lib, config, ... }:

{
  users.users.tjaros = {
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "chipwhisperer" ];
    shell = pkgs.fish;
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "tjaros";
  };
}
