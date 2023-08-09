{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ../modules
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      }))
    ];
    
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };


  home = {
    username = "tjaros";
    homeDirectory = "/home/tjaros";
  };

  modules.emacs.enable = true;
  modules.hypr.enable = true;

  home.packages = with pkgs; [ 
    spotify
    lutris
    wine
    winetricks
    runelite
    discord
    steam
    protonup-qt
    vscode
    xivlauncher
    zoom-us
    transmission-qt
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
