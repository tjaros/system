{ inputs, pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.neovim;
  astro-nvim = builtins.fetchGit {
    url = "https://github.com/AstroNvim/AstroNvim";
    ref = "refs/tags/v3.38.0";
  };
in {
  options.modules.neovim.enable = mkEnableOption "neovim config without lazy nvim";
  
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lazygit
      bottom
      gdu
    ];

    home.file.".config/nvim".source = astro-nvim;

    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    home.file
  };
}
