{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    eww-wayland
    dunst
    foot
    theme-sh
    libnotify
    hyprpaper
    wofi
    pavucontrol
    networkmanagerapplet
    brightnessctl
    mpv
    wl-clipboard    
    sxiv
    jq
    socat
    xdotool
    unzip
    firefox
    keybase
    keybase-gui
    thunderbird
    keepassxc
    wget
  ];
}
