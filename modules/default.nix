{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "23.05";
  imports = [
    ./nixvim
    ./emacs
    ./hypr
    ./tmux
  ];
}
