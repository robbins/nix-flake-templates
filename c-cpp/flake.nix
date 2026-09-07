{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
# Don't follow nixpkgs because we want neovim to be pinned to avoid breakage
    neovim.url = "github:robbins/neovim-nix";
    utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, neovim }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = with pkgs; (mkShell.override { stdenv = gcc13Stdenv; }) {
          packages = [ 
            gnumake
            bear
            compdb
            clang-tools
            clang
            gdb
            valgrind 
# can extend further if we need
            neovim.nixvimConfigurations.${system}.c-cpp.config.build.package
          ];
        };
    });
}
