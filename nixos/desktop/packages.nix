{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    theme-sh
    pavucontrol
    neovim
    ripgrep
    nodejs_20
    rustup
    cargo
    lazygit
    networkmanagerapplet
    mpv
    wl-clipboard    
    sxiv
    xdotool
    unzip
    direnv
    nix-direnv
    brave
    pkg-config
    cmake
    gcc
    keybase
    keybase-gui
    thunderbird
    keepassxc
    wget
    usbutils
  ];
}
