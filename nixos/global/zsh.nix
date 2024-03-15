{ pkgs, ... }:

{
  packages = with pkgs; [
    starship
  ];
  programs.zsh = {
    enable = true;
  };
}
