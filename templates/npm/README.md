# Npm template

Drop-in `flake.nix` for Npm projects. Pulls in the Npm shell and the general lib.

## Setup

Copy `flake.nix` into your project root, then run:

    nix flake update

## Customisation

- `extraPackages` — add project-specific packages here
- `extraShellHook` — add env variables or startup messages here
- To add Podman: uncomment `podmanLib` in `inputs` and the two matching lines in `optionalPackages`/`optionalHook`
- To add QEMU: same pattern with `qemuLib`
