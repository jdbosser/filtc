let
  pkgs = import <nixpkgs> {};
  newpkgs = import pkgs.path { overlays = [ 


  (self: super: {
    python310 = let
      packageOverrides = python-self: python-super: {
        filtc = self.python310.pkgs.callPackage (import ./pack.nix) {};
      };
    in super.python310.override {inherit packageOverrides;};
  } ) 


  (self: super: {
    python39 = let
      packageOverrides = python-self: python-super: {
        filtc = self.python39.pkgs.callPackage (import ./pack.nix) {};
      };
    in super.python39.override {inherit packageOverrides;};
  } ) 

  ]; };
in newpkgs.python39.withPackages (p: [p.filtc])
