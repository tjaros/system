{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    zlib
    zlib.dev
    unstable.pyenv
  ];
}
