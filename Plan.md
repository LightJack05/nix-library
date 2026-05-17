# Nix flake template repo

This repo contains template nix flakes for inclusion in projects. The structure is organized into three directories: `templates`, `lib`, and `shells`, each with subdirectories per project type (e.g. `go`, `kubebuilder`).

## Directory structure

```
nix-library/
├── shells/
│   ├── go/
│   │   ├── flake.nix
│   │   └── README.md
│   ├── kubebuilder/
│   │   ├── flake.nix
│   │   └── README.md
│   ├── operator-sdk/
│   │   ├── flake.nix
│   │   └── README.md
│   ├── python/
│   │   ├── flake.nix
│   │   └── README.md
│   ├── bash/
│   │   ├── flake.nix
│   │   └── README.md
│   ├── dotnet/
│   │   ├── flake.nix
│   │   └── README.md
│   ├── c/
│   │   ├── flake.nix
│   │   └── README.md
│   └── npm/
│       ├── flake.nix
│       └── README.md
├── lib/
│   ├── general/
│   │   ├── flake.nix
│   │   └── README.md
│   ├── podman/
│   │   ├── flake.nix
│   │   └── README.md
│   └── qemu/
│       ├── flake.nix
│       └── README.md
└── templates/
    ├── go/
    │   ├── flake.nix
    │   └── README.md
    ├── kubebuilder/
    │   ├── flake.nix
    │   └── README.md
    ├── operator-sdk/
    │   ├── flake.nix
    │   └── README.md
    ├── python/
    │   ├── flake.nix
    │   └── README.md
    ├── bash/
    │   ├── flake.nix
    │   └── README.md
    ├── dotnet/
    │   ├── flake.nix
    │   └── README.md
    ├── c/
    │   ├── flake.nix
    │   └── README.md
    └── npm/
        ├── flake.nix
        └── README.md
```

## Shells

Each flake under `shells/` defines the baseline dev environment for a project type. It exposes a single `devShells.default` output for all supported systems (`x86_64-linux`, `aarch64-linux`, `x86_64-darwin`, `aarch64-darwin`).

The shell hook must print:
1. The name of the included flake (e.g. `"Go development shell ready"`)
2. The versions of the key toolchain packages, queried programmatically (e.g. `go version`, `python --version`)

Use `nixpkgs-unstable` as the nixpkgs input unless there is a specific reason to pin to stable.

### Project type notes

- **Kubebuilder**: Go toolchain + `controller-gen`, `kustomize`, `kubectl`, `kind`. This is the base for operator development.
- **Operator SDK**: Extends Kubebuilder with `operator-sdk` and `helmify`. Should pull in the kubebuilder shell as a base rather than duplicating packages.
- **Python**: Include `python3`, `pip`, and a virtualenv wrapper.
- **Bash**: Include `shellcheck`, `shfmt`, `bash`.
- **C# .NET**: Include the `dotnet-sdk` package.
- **C**: Include `gcc`, `gdb`, `clang`, `cmake`, `pkg-config`.
- **NPM/JS**: Include `nodejs` and `nodePackages.npm`.

## Libs

Each flake under `lib/` is a self-contained flake exposing two outputs per system:
- `packages.<system>` — the set of packages this lib contributes
- `shellHook.<system>` — a string to be appended to the shell hook (may be empty)

Templates merge lib packages and hooks into their dev shell. This allows libs to be added to a project simply by adding the lib flake as an input and merging its outputs.

### Available libs

- **general** — Common tools every project needs: `curl`, `gnumake`, `jq`, `git`. Included automatically in all templates.
- **podman** — `podman`, `podman-compose`, with `KIND_EXPERIMENTAL_PROVIDER=podman` set via shellHook.
- **qemu** — `qemu`, `OVMF` (or similar), with any required env setup in shellHook.

## Templates

Flakes under `templates/` are the files that get dropped directly into project repos. Each one:

1. Declares the corresponding shell flake from this repo as a flake input (pinned via `flake.lock`)
2. Declares `lib/general` as an input (always included)
3. Exposes an empty `extraPackages` list to extend the baseline package set
4. Exposes an empty `shellHook` string for project-specific env variables or print statements
5. Merges the shell's packages + the general lib's packages + `extraPackages`
6. Appends the shell's hook + the general lib's hook + the project `shellHook`

Example input block in a template:

```nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  nix-library.url = "github:LightJack05/nix-library";  # or gitea URL
  # Optionally add lib inputs:
  # nix-library-podman.url = "github:LightJack05/nix-library?dir=lib/podman";
};
```

The template should be easy to extend: adding podman support should require only adding the input and merging it in the clearly marked extension sections.

## Required shells

- Go
- Kubebuilder
- Operator SDK (extends Kubebuilder)
- Python
- Bash
- C# .NET
- C
- NPM/JS

## Required libs

- General (auto-included in all templates)
- Podman
- Qemu

## Documentation

Every flake directory must contain a `README.md` alongside `flake.nix`. The README should be minimal and practical — no lengthy prose. It must include:

### For shells

- One-line description of what the shell provides
- List of included packages (with a brief note on any non-obvious ones)
- A quick-copy snippet showing how to reference it as a flake input

Example structure:
```markdown
# Go shell

Dev shell for Go projects. Includes: `go`, `gopls`, `gotools`, `delve`.

## Usage as input

    inputs.nix-library-go-shell.url = "gitea.lightjack.de/LightJack05/nix-library?dir=shells/go";

See `templates/go/` for a ready-to-use template that already wires this in.
```

### For libs

- One-line description of what the lib adds
- List of packages and any env vars/hook side effects
- A quick-copy snippet for adding the lib to an existing template

Example structure:
```markdown
# Podman lib

Adds Podman to the dev shell. Sets `KIND_EXPERIMENTAL_PROVIDER=podman` in the shell hook.

Packages: `podman`, `podman-compose`.

## Adding to a template

1. Add the input:

       inputs.nix-library-podman.url = "gitea.lightjack.de/LightJack05/nix-library?dir=lib/podman";

2. Merge into your shell (see the marked extension sections in the template flake).
```

### For templates

- One-line description
- Quick-copy snippet for dropping the template into a project (e.g. `nix flake init` or manual copy instructions)
- Short list of what to customise after copying (the `extraPackages` list, the `shellHook` string, optional lib inputs)

Example structure:
```markdown
# Go template

Drop-in `flake.nix` for Go projects. Pulls in the Go shell from `shells/go/` and the general lib.

## Setup

Copy `flake.nix` into your project root, then run:

    nix flake update

## Customisation

- `extraPackages` — add project-specific packages here
- `shellHook` — add env variables or startup messages here
- To add Podman support, uncomment the podman input and merge lines (marked in the file)
```
