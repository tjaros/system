{ inputs, outputs, config, pkgs, lib, ... }:


{

  nixpkgs = {
    overlays  = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/tjaros/dwm.git";
            rev = "17e694ba08e6571f7ee19df15a2630e1995a0ebd";
          }; 
        });
      })
    ];

    config = {
      allowUnfree = true;
    };
  };

  imports =
    [
      ./desktop
      ./global/startx.nix
      ./global/fish.nix
      ./global/fonts.nix
      ./global/nvidia.nix
      ./global/keybase.nix
      ./global/locale.nix
      ./global/misc.nix
      ./global/pipewire.nix
      ./global/udev.nix
      ./global/virtualization.nix
      ./global/development.nix
      ./hardware-configuration.nix
      ./users/tjaros
    ];

  programs.flatpak.enable = true;
  
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

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

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  system.stateVersion = "23.05"; 

}
