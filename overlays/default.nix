{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # I want to override quartus-prime-lite package so that i can download zip from url and extract it to one of the install folders
    #    quartus-lite = let
    #      eclipse-nios = builtins.fetchtarball {
    #        url = "https://archive.eclipse.org/technology/epp/downloads/release/mars/2/eclipse-cpp-mars-2-linux-gtk-x86_64.tar.gz";
    #      };
    #    in
    #      prev.quartus-lite.overrideAttrs (oldAttrs:
    #			inherit unwrapped;
    #	  rec {
    #        postInstall =
    #          (oldAttrs.postInstall or "")
    #          + ''
    #            mkdir -p ${unwrapped}/opt/quartus/touch
    #          '';
    #      });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
