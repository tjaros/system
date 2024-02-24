{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    theme-sh
    glibc
    pavucontrol
    gcc-arm-embedded
    bear
    ripgrep
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
    pkg-config
    firefox
    cmake
    gcc
    thunderbird
    keepassxc
    wget
    usbutils
  ];
}
