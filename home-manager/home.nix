{ inputs, outputs, lib, config, pkgs, ... }:

let 
  python = (pkgs.unstable.python311.withPackages(ps: with ps; [
      pip
      virtualenv

      # LSP
      python-lsp-server
      python-lsp-server.optional-dependencies.all

      epc
      orjson
      sexpdata
      paramiko
    ]));
in
{
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

  modules.emacs.enable = false;

  home.packages = with pkgs; [
    python
    unstable.cargo
    unstable.rustc
    zathura
    unstable.lunarvim
    unstable.helix
    spotify
    networkmanager-openvpn
    openvpn
    unrar
    xournalpp
    unzip
    lutris
    wine
    winetricks
    gimp
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
    antimicrox
    distrobox
    steam
    vscode
    gnumake
    llvmPackages_9.clang-unwrapped
    protontricks
    black
    pylint
    
    R
    rstudio
    
    
    
    unstable.zoom-us
    transmission-qt
  ];

  home.sessionVariables = {
    PYTHONPATH = "${python}/${python.sitePackages}";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
