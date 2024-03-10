{
  description = "Nix flake templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    templates = {
      haskell = {
        path = ./haskell;
        description = "A simple Haskell dev shell";
      };
      python = {
        path = ./python;
        description = "A simple Python dev shell";
      };
      java = {
        path = ./java;
        description = "A simple Java dev shell";
      };
    };
  };
}
