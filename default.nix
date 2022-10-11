{pkgs ? import <nixpkgs> {} }:
with pkgs;
let 
   mpkg = import ./python_shell.nix;
in 
mkShell {
    buildInputs = [(python3Packages.callPackage mpkg {})];
}
