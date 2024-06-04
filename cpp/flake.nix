{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = with pkgs; (mkShell.override { stdenv = clang17Stdenv; }) {
          packages = [ cppcheck gdb valgrind clang-tools_18 gcc13 ];
        };
    });
}
