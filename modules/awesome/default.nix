{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.modules.awesome;
in 
{
  options.modules.awesome = {
    enable = mkEnableOption "Enable AwesomeWM desktop support for this machine";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.displayManager = {
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
}
