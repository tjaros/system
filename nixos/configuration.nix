{ inputs, outputs, config, pkgs, lib, ... }:

{

  nixpkgs = {
    overlays  = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/tjaros/dwm.git";
            rev = "a2db2f6146eb00ae674ed76701442d14d04ddfcc";
          }; 
        });
      })

      (self: super: {
        dwmbar = super.dwmbar.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/tjaros/dwmbar.git";
            rev = "f1126289134deb24e62193276068cfbb18c5789b";
          }; 
        });
      })
    ];
  };

  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./desktop
      ./global/dwm.nix
      ./global/fish.nix
      ./global/fonts.nix
      ./global/keybase.nix
      ./global/locale.nix
      ./global/misc.nix
      ./global/nvidia.nix
      ./global/pipewire.nix
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

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      tjaros = import ../home-manager/home.nix;
    };
  };


  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05"; 

}
