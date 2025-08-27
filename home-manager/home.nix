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
    #python-packages
    #lunarvim
    #python
    unstable.cargo
    unstable.rustc
    zathura
    spotify
    prismlauncher
    stremio
    gp-saml-gui
    openconnect
    unstable.gfn-electron
    networkmanager-openvpn
    openvpn
    unrar
    element-desktop
    xournalpp
    unstable.chromium
    unzip
    steam
    gimp
    runelite
    moonlight-qt
    whatsapp-for-linux
    unstable.path-of-building
    libreoffice
    discord
    unstable.lutris
    obsidian
    graphviz
    inkscape
    remmina
    antimicrox
    distrobox
    vscode
    gnumake
    llvmPackages_12.clang-unwrapped
    unstable.koreader
    black
    jdk21_headless
    pylint
    verilog
    gtkwave
    vbindiff
    go
    zap

    gittyup

    #quartus-prime-lite
    unstable.texliveFull

    fzf
    bat

    unstable.zoom-us
    transmission-qt
  ];

  home.sessionVariables = {
    #PYTHONPATH = "${python}/${python.sitePackages}";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
