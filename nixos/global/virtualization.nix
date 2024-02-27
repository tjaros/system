{ pkgs, ... }: 

{
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    users.extraGroups.vboxusers.members = [ "tjaros" ];

    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [ 
        virt-manager
        vagrant
    ];
}
