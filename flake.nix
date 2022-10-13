{
  description = "A very basic flake";

    
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flakeutils.url = "github:numtide/flake-utils";
    render-anim.url = "github:jdbosser/render-anim";
    render-anim.flake = false;
  };


  outputs = { self, nixpkgs, flakeutils, render-anim }: 
    flakeutils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system}; 
        
        in
        rec {
            devShells.default =  pkgs.mkShell {
                  buildInputs = [
                    defaultPackage
                    # (pkgs.python3.withPackages (p: [
                    #     # p.numpy
                    #     # p.mypy
                    #     # p.pytest
                    #     defaultPackage
                    # ]))
                    # pkgs.pyright
                  ];
            };

            defaultPackage = pkgs.python39Packages.callPackage ./pack.nix {}; 

        }
    );
}
