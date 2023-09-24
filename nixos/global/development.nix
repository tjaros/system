{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    zlib
    unstable.pyenv
  ];
}
