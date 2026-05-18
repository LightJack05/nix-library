{
  description = "Kubebuilder development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
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
            kubernetes-controller-tools
            kubebuilder
            kustomize
            kubectl
            kind
          ];
          shellHook = ''
            echo "Kubebuilder development shell"
            go version
            kubectl version --client
          '';
        }
      );

      # Standalone dev shell (built from shellConfig)
      devShells = forAllSystems (system: {
        default = (nixpkgs.legacyPackages.${system}).mkShell {
          name = "kubebuilder-dev-shell";
          inherit (self.shellConfig.${system}) packages shellHook;
        };
      });
    };
}
