{
  description = "General-purpose development tools lib";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # List of packages this lib contributes, per system
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in [
          pkgs.curl
          pkgs.gnumake
          pkgs.jq
          pkgs.git
        ]
      );

      # Shell hook string to append (system-independent)
      shellHook = ''
        # general lib
      '';
    };
}
