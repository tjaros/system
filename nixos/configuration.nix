{ inputs, outputs, config, pkgs, lib, ... }:


let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{

  nixpkgs = {
    config = {
      packageOverrides = pkgs: with pkgs; {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
    };
    
    overlays  = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/tjaros/dwm.git";
            rev = "17e694ba08e6571f7ee19df15a2630e1995a0ebd";
          }; 
        });
      })
    ];
  };

  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./desktop
      ./global/gnome.nix
      ./global/fish.nix
      ./global/fonts.nix
      ./global/keybase.nix
      ./global/locale.nix
      ./global/misc.nix
      ./global/nvidia.nix
      ./global/pipewire.nix
      ./global/udev.nix
      ./global/virtualization.nix
      ./global/development.nix
      ./hardware-configuration.nix
      ./users/tjaros
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-4d65f029-de33-4194-9dbd-c929f7a04d6d".device = "/dev/disk/by-uuid/4d65f029-de33-4194-9dbd-c929f7a04d6d";
  boot.initrd.luks.devices."luks-4d65f029-de33-4194-9dbd-c929f7a04d6d".keyFile = "/crypto_keyfile.bin";

  networking = {
    hostName = "astora";
    networkmanager.enable = true;
  };

  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #};

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      tjaros = import ../home-manager/home.nix;
    };
  };

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
    };
  };


  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05"; 

}
