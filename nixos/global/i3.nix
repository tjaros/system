{ pkgs, ... }:

{
  services.xserver.displayManager = {
    sddm.enable = true;
    defaultSession = "plasma5+i3+whatever";
    session = [
        {
            manage = "desktop";
            name = "plasma5+i3+whatever";
            start = ''exec env KDEWM=${pkgs.i3-gaps}/bin/i3 ${pkgs.plasma-workspace}/bin/startplasma-x11'';
        }
    ];
};
}
