# BPF/CO-RE shell

Development shell for BPF programs with CO-RE (Compile Once – Run Everywhere). Linux only.

Packages: `clang`, `llvmPackages.llvm`, `gcc`, `pkg-config`, `gnumake`, `libbpf`, `bpftools` (provides `bpftool`), `linuxHeaders`, `zstd`

The Linux-only packages (`libbpf`, `bpftools`, `linuxHeaders`, `zstd`) are conditionally included via `lib.optionals stdenv.isLinux`.

Two compilers are available, with separate roles:

- `clang` / `gcc` (wrapped, in PATH) — for userspace/loader compilation; Nix's cc-wrapper injects store paths so headers and libraries resolve automatically.
- `$BPF_CLANG` (unwrapped, store path only) — for BPF kernel-side compilation; bypasses the cc-wrapper host `--target` flag that conflicts with `--target bpf`. It is in the shell's closure but not in PATH to avoid ambiguity.

Two environment variables are exported:

- `BPF_CLANG` — absolute store path to the unwrapped clang binary
- `BPF_CFLAGS` — `-I<linuxHeaders>/include` (Linux only); required because the unwrapped compiler does not get Nix's automatic header injection

Example Makefile:

    # BPF kernel-side object
    prog.bpf.o: prog.bpf.c
        $(BPF_CLANG) -target bpf $(BPF_CFLAGS) $(shell pkg-config --cflags libbpf) -c $< -o $@

    # Userspace loader
    loader: loader.c
        clang $(shell pkg-config --cflags --libs libbpf) $< -o $@

## As a flake input

    inputs.bpfShell.url = "git+https://github.com/LightJack05/nix-library?dir=shells/bpf";

Reference `bpfShell.shellConfig.${system}.packages` and `bpfShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/bpf/` for a ready-to-use template.
