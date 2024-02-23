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
      ./global/gnome.nix
      ./global/zsh.nix
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
  
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };


  networking = {
    hostName = "lordaeron";
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
