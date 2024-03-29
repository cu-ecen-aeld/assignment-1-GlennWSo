{
  description = "A devShell that can run three-d examples";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs,  flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };


        buildDeps = with pkgs; [
          cmake
          ruby
        ];

        dev_tools = with pkgs; [
          clang-tools
        ];
      in
      with pkgs;
      {
        devShells.default = mkShell {
          name = "rust graphics env"; 
          buildInputs = buildDeps ++ dev_tools;
          shellHook = ''
            echo hi
          '';
        };
      }
    );
}
