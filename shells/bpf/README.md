# BPF/CO-RE shell

Development shell for BPF programs with CO-RE (Compile Once – Run Everywhere). Linux only.

Packages: `clang`, `llvm`, `gcc`, `pkg-config`, `gnumake`, `libbpf`, `bpftools` (provides `bpftool`), `linuxHeaders`

The Linux-only packages (`libbpf`, `bpftools`, `linuxHeaders`) are conditionally included via `lib.optionals stdenv.isLinux`.

## As a flake input

    inputs.bpfShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/bpf";

Reference `bpfShell.shellConfig.${system}.packages` and `bpfShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/bpf/` for a ready-to-use template.
