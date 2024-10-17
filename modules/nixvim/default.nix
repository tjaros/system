{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keys.nix
    ./settings.nix
    ./plugins
  ];

  options.modules.nixvim = {enable = mkEnableOption "nixvim";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lazygit
      zoxide
    ];

    programs.nixvim = {
      enable = true;
      colorschemes.rose-pine = {
        enable = true;
        settings.enable.transparency = true;
      };
    };
  };
}
