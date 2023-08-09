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
        sha256 = "1pk4gvpadyh1zhj4g3fjv69nqyb68agkz83cx5v0yryczbdpq6r2";
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
