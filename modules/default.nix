{ inputs, config, pkgs, ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./i3
    ./emacs
  ];
}
