{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nixvim;

in {
  options.modules.nixvim= { enable = mkEnableOption "nixvim"; };
    config = mkIf cfg.enable {
      programs.nixvim.enable = true;
    };
}
