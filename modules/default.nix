{ inputs, config, pkgs, ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./awesome
    ./emacs
  ];
}
