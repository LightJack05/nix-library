# Podman lib

Adds Podman container tooling to the shell environment.

Packages: `podman`, `podman-compose`.
Sets `KIND_EXPERIMENTAL_PROVIDER=podman` so that kind uses Podman as its container provider.

## Adding to a template

1. Add the input:

       inputs.podmanLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/podman";

2. Add the input name to the `outputs` function arguments.

3. Merge into the shell (in the clearly marked extension sections in any template):
   - Append `.podmanLib.packages.${system}` to the packages list
   - Append `.podmanLib.shellHook` to the shellHook string
