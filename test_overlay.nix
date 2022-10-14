let
  pkgs = import <nixpkgs> {};
  newpkgs = import pkgs.path { overlays = [ (self: super: {
    python310 = let
      packageOverrides = python-self: python-super: {
        filtc = self.python310.pkgs.callPackage (import ./pack.nix) {};
      };
    in super.python310.override {inherit packageOverrides;};
  } ) ]; };
in newpkgs.python310.withPackages (p: [p.filtc])
