{
  description = "Go license collector lib";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    go-license-collector.url = "github:LightJack05/go-license-collector";
  };

  outputs = { self, nixpkgs, go-license-collector }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # List of packages this lib contributes, per system
      packages = forAllSystems (system:
        [
          go-license-collector.packages.${system}.go-license-collector
        ]
      );

      # Shell hook string to append (system-independent)
      shellHook = ''
      '';
    };
}
