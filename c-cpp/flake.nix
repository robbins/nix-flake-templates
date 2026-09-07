{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim.url = "github:robbins/neovim-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, neovim, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, system, ... }: {
        devShells.default = (pkgs.mkShell.override { stdenv = pkgs.clang_22.stdenv; }) {
          packages = with pkgs; [ 
            gnumake
            bear
            compdb
            clang-tools
            clang
            gdb
            valgrind 
            cppcheck
          ] ++ [
            # We can extend further if needed
            neovim.nixvimConfigurations.${system}.c-cpp.config.build.package
          ];
        };
        formatter = pkgs.nixfmt-tree;
    };
  };
}
