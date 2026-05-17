# kind lib

Adds [kind](https://kind.sigs.k8s.io/) (Kubernetes in Docker/Podman) to the dev shell.

Packages: `kind`.

Pair with `lib/podman/` and set `KIND_EXPERIMENTAL_PROVIDER=podman` to use kind with Podman instead of Docker.

## Adding to a template

1. Add the input:

       inputs.kindLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/kind";

2. Add the input name to the `outputs` function arguments.

3. Merge into the shell (in the clearly marked extension sections in any template):
   - Append `kindLib.packages.${system}` to the packages list
