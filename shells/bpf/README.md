# BPF/CO-RE shell

Development shell for BPF programs with CO-RE (Compile Once – Run Everywhere). Linux only.

Packages: `llvmPackages.clang-unwrapped`, `llvmPackages.llvm`, `gcc`, `pkg-config`, `gnumake`, `libbpf`, `bpftools` (provides `bpftool`), `linuxHeaders`, `zstd`

The Linux-only packages (`libbpf`, `bpftools`, `linuxHeaders`) are conditionally included via `lib.optionals stdenv.isLinux`.

The shell uses `clang-unwrapped` instead of the standard wrapped `clang` to avoid the cc-wrapper injecting a host `--target` flag that conflicts with `--target bpf`. Two environment variables are exported for use in Makefiles and build scripts:

- `BPF_CLANG` — absolute path to the unwrapped clang binary
- `BPF_CFLAGS` — `-I<linuxHeaders>/include` (Linux only); pass to clang when compiling BPF kernel-side code

Example Makefile usage:

    prog.bpf.o: prog.bpf.c
        $(BPF_CLANG) -target bpf $(BPF_CFLAGS) $(shell pkg-config --cflags libbpf) -c $< -o $@

## As a flake input

    inputs.bpfShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/bpf";

Reference `bpfShell.shellConfig.${system}.packages` and `bpfShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/bpf/` for a ready-to-use template.
