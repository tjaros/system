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
    in {

    overlays = import ./overlays { inherit inputs; };
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake ~/system/#astora'
    nixosConfigurations = {
      astora = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
