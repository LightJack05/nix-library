# C shell

Development shell for C projects.

Packages: `gcc`, `gdb`, `clang`, `cmake`, `pkg-config`, `gnumake`

## As a flake input

    inputs.cShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/c";

Reference `cShell.shellConfig.${system}.packages` and `cShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/c/` for a ready-to-use template.
