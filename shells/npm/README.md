# NPM/JS shell

Development shell for NPM/JavaScript projects.

Packages: `nodejs`, `nodePackages.npm`

## As a flake input

    inputs.npmShell.url = "git+https://github.com/LightJack05/nix-library?dir=shells/npm";

Reference `npmShell.shellConfig.${system}.packages` and `npmShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/npm/` for a ready-to-use template.
