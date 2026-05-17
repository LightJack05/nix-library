{
  description = "Go development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Mergeable config for use by templates
      shellConfig = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          packages = with pkgs; [
            go
            gopls
            gotools
            delve
          ];
          shellHook = ''
            echo "Go development shell"
            go version
          '';
        }
      );

      # Standalone dev shell (built from shellConfig)
      devShells = forAllSystems (system: {
        default = (nixpkgs.legacyPackages.${system}).mkShell {
          name = "go-dev-shell";
          inherit (self.shellConfig.${system}) packages shellHook;
        };
      });
    };
}
