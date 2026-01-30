{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    overlays = [
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

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  programs.nix-ld.enable = true;
  networking.wireguard.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  imports = [
    ./desktop
    ./global/fingerprint-reader.nix
    ./global/gnome.nix
    ./global/zsh.nix
    ./global/fonts.nix
    ./global/intel.nix
    ./global/locale.nix
    ./global/misc.nix
    ./global/pipewire.nix
    ./global/udev.nix
    ./global/virtualization.nix
    ./global/development.nix
    ./global/onepassword.nix
    ./hardware-configuration.nix
    ./users/tjaros
  ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Setup keyfile
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
  };

  security.pam.u2f = {
    enable = true;
    settings = {
      authfile = "/etc/u2f-mappings";
    };
  };

  networking = {
    hostName = "lordaeron";
    networkmanager.enable = true;
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = ["/etc/nix/path"];
  };
  environment = {
    etc =
      lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry
      // {
        u2f-mappings.text = ''
          tjaros:wrT3Or/8SoBi19wgEx1CWh4OE6ELTfHHZnDYevNfX6bEXC9IKU4kKUs33imVm5s8JKQRTp9sRWpoNwd9pMVRSQ==,uWrGt2Y+GYf6BEiG+ZJ2/PyRVvS0zqwxH5mVBBuYSrUAvV41zgc7ypuGX1idHRmKdJ6m7k4Ly9CK7NoiCnOOhA==,es256,+presence
        '';
      };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # services.sunshine = {
  #  enable = true;
  #  autoStart = true;
  #  capSysAdmin = true;
  #  openFirewall = true;
  #  
  #};


  system.stateVersion = "23.05";
}
