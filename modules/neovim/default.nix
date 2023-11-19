{ inputs, pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.neovim;
in {
  options.modules.neovim.enable = mkEnableOption "neovim config";
  
  config = mkIf cfg.enable {
    home.packages = with pkgs.unstable; [
      lunarvim
    ];

    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

  };
}
