{
  description = "Operator SDK development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    kubebuilderShell.url = "git+https://github.com/LightJack05/nix-library?dir=shells/kubebuilder";
  };

  outputs = { self, nixpkgs, kubebuilderShell }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Mergeable config for use by templates
      shellConfig = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          helmify = pkgs.buildGoModule {
            pname = "helmify";
            version = "0.4.19";
            src = pkgs.fetchFromGitHub {
              owner = "arttor";
              repo = "helmify";
              rev = "v0.4.19";
              hash = "sha256-casZJRHpTbakI1FdSYPYcda2G8xPP+feTQil6R+FdbE=";
            };
            vendorHash = "sha256-ShX11hDA8oPkvT37vYArL8VzthfWdxbq9mvpYuL/0gE=";
            subPackages = [ "cmd/helmify" ];
          };
        in {
          packages = kubebuilderShell.shellConfig.${system}.packages ++ [
            pkgs.operator-sdk
            helmify
          ];
          shellHook = kubebuilderShell.shellConfig.${system}.shellHook + ''
            echo "Operator SDK development shell"
            operator-sdk version
          '';
        }
      );

      # Standalone dev shell (built from shellConfig)
      devShells = forAllSystems (system: {
        default = (nixpkgs.legacyPackages.${system}).mkShell {
          name = "operator-sdk-dev-shell";
          inherit (self.shellConfig.${system}) packages shellHook;
        };
      });
    };
}
