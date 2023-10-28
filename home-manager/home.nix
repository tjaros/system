{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ../modules
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/573d65a4ddd835f7b1c0600b2b115aeab4fa18a9.tar.gz;
        sha256 = "04fcr3ns2hinqypxvfc6niyjjzr5mmqrwvjhxz6x1mwgfvgjicrv";
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

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
      };
  };

  modules.emacs.enable = true;

  home.packages = with pkgs; [
    (python311.withPackages(ps: with ps; [
      pip
      virtualenv

      epc
      orjson
      sexpdata
      paramiko
    ]))

    
    spotify
    networkmanager-openvpn
    openvpn
    unrar
    unzip
    lutris
    wine
    winetricks
    runelite
    skypeforlinux
    chromium
    autokey
    flatpak
    libreoffice
    discord
    ghidra-bin
    graphviz
    inkscape
    teams
    antimicrox
    distrobox
    steam
    vscode
    gnumake
    protontricks
    obsidian
    
    R
    rstudio
    
    
    
    zoom-us
    transmission-qt
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
