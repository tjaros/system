{
  pkgs,
  lib,
  config,
  ...
}: {
  users.users.tjaros = {
    initialPassword = "correcthorsebatterystaple";
    isNormalUser = true;
    description = "Tom";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "docker" "chipwhisperer" "libvirtd" "dialout" "input" "uinput" "plugdev"];
    shell = pkgs.zsh;
  };

  services.xserver.displayManager.autoLogin = {
    enable = false;
    user = "tjaros";
  };
}
