{
  description = "Python development shell 3.11";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python311.withPackages (ps: with ps; [
        virtualenv
        pip
        black
        python-lsp-server
        python-lsp-ruff
        pyls-isort
        pylsp-rope
        pylint
        pyserial
        numpy
        ipython
        matplotlib
        seaborn
        pyqt5
        

        # The lsp-bridge plugin has nasty python dependencies
        # not sure how to isolate them for emacs to use and
        # and at the same time having working direnv shells
        #epc
        #orjson
        #sexpdata
        #paramiko
      ]);
    in {
      devShells.default = pkgs.mkShell rec {
        packages = with pkgs; [
          usbutils
          cmake
          python
          screen
          gcc-arm-embedded
          ripgrep
        ];

        buildInputs = with pkgs;[
          libz
          python
          stdenv.cc.cc
        ];

        
        shellHook = ''
          # Tells pip to put packages into $PIP_PREFIX instead of the usual locations.
          # See https://pip.pypa.io/en/stable/user_guide/#environment-variables.
          export PIP_PREFIX=$(pwd)/_build/pip_packages
          export PYTHONPATH="$PIP_PREFIX/${python.sitePackages}:$PYTHONPATH"
          export PATH="${python}/bin:$PIP_PREFIX/bin:$PATH"
          unset SOURCE_DATE_EPOCH
          export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH"
        '';
      };
    });
}
