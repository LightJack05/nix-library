# QEMU lib

Adds QEMU virtualisation tools to the shell environment.

Packages: `qemu`.

## Adding to a template

1. Add the input:

       inputs.qemuLib.url = "git+https://github.com/LightJack05/nix-library?dir=lib/qemu";

2. Add the input name to the `outputs` function arguments.

3. Merge into the shell (in the clearly marked extension sections in any template):
   - Append `.qemuLib.packages.${system}` to the packages list
   - Append `.qemuLib.shellHook` to the shellHook string
