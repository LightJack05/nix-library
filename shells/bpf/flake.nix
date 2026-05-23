{
  description = "BPF/CO-RE development shell (Linux only)";

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
            clang
            llvm
            gcc
            pkg-config
            gnumake
          ] ++ lib.optionals stdenv.isLinux [
            libbpf
            bpftools
            linuxHeaders
          ];
          shellHook = ''
            echo "BPF/CO-RE development shell"
            clang --version | head -1
            bpftool version 2>/dev/null | head -1 || true
          '';
        }
      );

      # Standalone dev shell (built from shellConfig)
      devShells = forAllSystems (system: {
        default = (nixpkgs.legacyPackages.${system}).mkShell {
          name = "bpf-dev-shell";
          inherit (self.shellConfig.${system}) packages shellHook;
        };
      });
    };
}
