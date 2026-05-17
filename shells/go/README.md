# Go shell

Development shell for Go projects.

Packages: `go`, `gopls`, `gotools`, `delve`

## As a flake input

    inputs.goShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/go";

Reference `goShell.shellConfig.${system}.packages` and `goShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/go/` for a ready-to-use template.
