{
  description = "LaTeX development shell";

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
            texlive.combined.scheme-full
            perlPackages.LatexIndent
            gnumake
            inkscape
          ];
          shellHook = ''
            echo "LaTeX development shell"
            pdflatex --version | head -1
          '';
        }
      );

      # Standalone dev shell (built from shellConfig)
      devShells = forAllSystems (system: {
        default = (nixpkgs.legacyPackages.${system}).mkShell {
          name = "latex-dev-shell";
          inherit (self.shellConfig.${system}) packages shellHook;
        };
      });
    };
}
