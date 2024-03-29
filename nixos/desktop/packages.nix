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
    zlib
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
    unstable.keybase
    unstable.keybase-gui
    thunderbird
    keepassxc
    wget
    usbutils
  ];
}
