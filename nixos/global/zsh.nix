{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    starship
  ];
  programs.zsh = {
    enable = true;
  };
}
