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
        devShell = with pkgs; mkShell {
          buildInputs = [ (python311.withPackages (p: [ p.pylint p.flake8 ])) ];
        };
    });
}
