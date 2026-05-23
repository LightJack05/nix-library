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
            # Wrapped clang/gcc for userspace (loader) compilation.
            # clang-unwrapped is kept out of PATH and accessed only via $BPF_CLANG
            # so there is no ambiguity about which compiler is used for which target.
            clang
            llvmPackages.llvm
            gcc
            pkg-config
            gnumake
          ] ++ lib.optionals stdenv.isLinux [
            libbpf
            bpftools
            linuxHeaders
            zstd
          ];
          shellHook = ''
            echo "BPF/CO-RE development shell"
            clang --version | head -1
            bpftool version 2>/dev/null | head -1 || true
            # clang-unwrapped is in the closure but not in PATH; use $BPF_CLANG for
            # BPF kernel-side compilation to avoid the cc-wrapper host --target flag.
            export BPF_CLANG="${pkgs.llvmPackages.clang-unwrapped}/bin/clang"
          '' + pkgs.lib.optionalString pkgs.stdenv.isLinux ''
            export BPF_CFLAGS="-I${pkgs.linuxHeaders}/include"
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
