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
  #services.lact.enable = true;


  programs = {
    # Enable Steam Game
    # Gamescope session inside game.
    # gamemoderun gamescope -W 2560 -H 1440 -r 60 --mangoapp -f -b --force-grab-cursor -- %command%
    # dont use -F fsr, if its crashing on launch.
    # dont use -e, game will be hidden.
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession = {
        # Optimized micro-compositor. Use the Steam launch option: gamescope %command%
        enable = true;
      };
      package = pkgs.steam.override {
        extraPkgs = pkgs':
          with pkgs'; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib # Provides libstdc++.so.6
            libkrb5
            keyutils
            # Add other libraries as needed
          ];
      };
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    #gamescope = {
    #  	enable = true;
    #    capSysNice = true;
    #};
    # Gamemode
    gamemode = {
      # Feral Interactive optimizations. Use Steam launch option: gamemoderun %command%
      enable = true;
      settings = {};
      enableRenice = true;
    };
    # Gamescope, Dont use separate gamescope as this is causing steam gamescopeSession issue.
    # gamescope = {
    #   enable = true;
    #   package = pkgs.gamescope;
    #   capSysNice = true;
    # };
  };


  hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        rocmPackages.clr.icd # AMD required pkg
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva-vdpau-driver
        libvdpau-va-gl
        # rocmPackages.clr.icd # AMD required pkg
      ];
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
  services.hardware.bolt.enable = true;

  # services.sunshine = {
  #  enable = true;
  #  autoStart = true;
  #  capSysAdmin = true;
  #  openFirewall = true;
  #  
  #};


  system.stateVersion = "23.05";
}
