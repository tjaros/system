{
  description = "Tom's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake ~/system/#astora'
    nixosConfigurations = {
      astora = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [
          ({ config, pkgs, ...}: { nixpkgs.overlays = [ overlay-unstable ]; })
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
