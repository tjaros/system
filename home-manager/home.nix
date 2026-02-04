{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  python = pkgs.unstable.python311.withPackages (ps:
    with ps; [
      pip
      virtualenv

      pyautogui
      tkinter
    ]);
in {
  imports = [
    ../modules
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/573d65a4ddd835f7b1c0600b2b115aeab4fa18a9.tar.gz;
        sha256 = "04fcr3ns2hinqypxvfc6niyjjzr5mmqrwvjhxz6x1mwgfvgjicrv";
      }))
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
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

  modules.tmux.enable = true;
  modules.nixvim.enable = true;


  home.packages = with pkgs; [
    lunarvim
    unstable.cargo
    unstable.rustc
    zathura
    spotify
    openconnect
    networkmanager-openvpn
    openvpn
    telegram-desktop
    unrar
    element-desktop
    gnuplot
    picoscope
    xournalpp
    unstable.chromium
    unzip
    gimp
    runelite
    libreoffice
    discord
    unstable.lutris
    obsidian
    heroic
    graphviz
    remmina
    antimicrox
    unstable.vscode
    gnumake
    unstable.koreader
    black
    jdk21_headless
    pylint
    iverilog
    gtkwave
    vbindiff



    gittyup

    #quartus-prime-lite
    fzf
    bat

    unstable.zoom-us


        steam-run
    sgdboop # steamgriddb
    mangohud

    # Roms Manager
    steam-rom-manager

    # PS
    pcsx2

    # Vulkan tools
    vulkan-tools
    mesa-demos

    # Additional tools
    libstrangle
  ];

  home.sessionVariables = {
    #PYTHONPATH = "${python}/${python.sitePackages}";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
