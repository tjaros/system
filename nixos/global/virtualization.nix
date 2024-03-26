{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.extraGroups.vboxusers.members = ["tjaros"];

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    vagrant
  ];
}
