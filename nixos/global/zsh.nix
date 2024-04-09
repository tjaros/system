{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    starship
  ];
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      eval "$(starship init zsh)"
    '';
  };
}
