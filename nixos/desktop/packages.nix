{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    theme-sh
    pavucontrol
    networkmanagerapplet
    mpv
    wl-clipboard    
    sxiv
    xdotool
    unzip
    direnv
    nix-direnv
    firefox
    keybase
    keybase-gui
    thunderbird
    keepassxc
    wget
  ];
}
