# nix-library

A collection of reusable Nix flakes for development shells. Organised into three layers:

- **`shells/`** — baseline dev environments per project type (Go, Python, C, etc.)
- **`lib/`** — optional add-ons (Podman, QEMU, general tools) that can be mixed in
- **`templates/`** — drop-in `flake.nix` files for project repos, wiring a shell and libs together

## How it works

Each **shell** exposes a `shellConfig.<system>` attribute with `packages` and `shellHook`. Templates import a shell and merge its config alongside any libs they include. This means:

- Shells can be used standalone (`nix develop`) or composed into templates
- Libs are opt-in: uncomment a few lines in the template to add Podman or QEMU
- Templates have two clearly marked extension points for project-specific additions: `extraPackages` and `extraShellHook`

## Quick start

Copy the template for your project type into your repo root:

```
cp <(nix run nixpkgs#curl -- -sL \
  "https://github.com/LightJack05/nix-library/raw/branch/main/templates/go/flake.nix") \
  flake.nix
nix flake update
nix develop
```

Or just grab the raw `flake.nix` from `templates/<type>/` and drop it in.

## Available project types

| Type | Shell | Template |
|---|---|---|
| Go | `shells/go/` | `templates/go/` |
| Kubebuilder | `shells/kubebuilder/` | `templates/kubebuilder/` |
| Operator SDK | `shells/operator-sdk/` | `templates/operator-sdk/` |
| Python | `shells/python/` | `templates/python/` |
| Bash | `shells/bash/` | `templates/bash/` |
| C# .NET | `shells/dotnet/` | `templates/dotnet/` |
| C | `shells/c/` | `templates/c/` |
| NPM/JS | `shells/npm/` | `templates/npm/` |
| LaTeX | `shells/latex/` | `templates/latex/` |
| BPF/CO-RE | `shells/bpf/` | `templates/bpf/` |
| Ansible | `shells/ansible/` | `templates/ansible/` |

## Available libs

| Lib | What it adds |
|---|---|
| `lib/general/` | `curl`, `gnumake`, `jq`, `git` — included in every template automatically |
| `lib/podman/` | `podman`, `podman-compose`, sets `KIND_EXPERIMENTAL_PROVIDER=podman` |
| `lib/qemu/` | `qemu` |
| `lib/go-license-collector/` | `go-license-collector` — collects and verifies Go dependency licenses |
| `lib/kind/` | `kind` — local Kubernetes clusters; pair with `lib/podman/` |

## Adding a lib to a template

Each template already has the optional libs pre-wired as comments. To enable Podman, for example:

1. Uncomment the input:
   ```nix
   podmanLib.url = "git+https://github.com/LightJack05/nix-library?dir=lib/podman";
   ```
2. Uncomment the two merge lines in `optionalPackages` and `optionalHook`.
3. Run `nix flake update`.

## Flake URL reference

```
# A shell
git+https://github.com/LightJack05/nix-library?dir=shells/go

# A lib
git+https://github.com/LightJack05/nix-library?dir=lib/podman

# A template (copy the file directly rather than importing it)
https://github.com/LightJack05/nix-library/raw/branch/main/templates/go/flake.nix
```
