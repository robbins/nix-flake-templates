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
    };
  };
}
