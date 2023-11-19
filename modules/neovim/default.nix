{ inputs, pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.neovim;
  neovim-config = builtins.fetchGit {
    url = "https://github.com/tjaros/neovim-config.git";
    rev = "7521832d84f0d3875255afee4e7eefeab474d645";
  };
in {
  options.modules.neovim.enable = mkEnableOption "neovim config without lazy nvim";
  
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lazygit
      bottom
      gdu
    ];

    home.file.".config/nvim".source = neovim-config;

    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

  };
}
