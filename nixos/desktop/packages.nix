{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    theme-sh
    glibc
    pavucontrol
    gcc-arm-embedded
    bear
    ripgrep
    tmux
    nodejs_20
    rustup
    cargo
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
