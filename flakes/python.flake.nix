{
  description = "Python development shell 3.11";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python310.withPackages (ps: with ps; [
        virtualenv
        pip
        ipykernel
        numpy
        scipy
        pandas
        matplotlib
        seaborn
        click
        setuptools
        tqdm
        pycryptodome


        # The lsp-bridge plugin has nasty python dependencies
        # not sure how to isolate them for emacs to use and
        # and at the same time having working direnv shells
        epc
        orjson
        sexpdata
        paramiko
      ]);
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          jupyter
          python
          sage
          ripgrep
          jetbrains.pycharm-community
        ];

        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
      };
    });
}
