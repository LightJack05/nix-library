# General lib

Adds common general-purpose development tools to the shell environment.

Packages: `curl`, `gnumake`, `jq`, `git`.

## Adding to a template

1. Add the input:

       inputs.generalLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/general";

2. Add the input name to the `outputs` function arguments.

3. Merge into the shell (in the clearly marked extension sections in any template):
   - Append `.generalLib.packages.${system}` to the packages list
   - Append `.generalLib.shellHook` to the shellHook string
