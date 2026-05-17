# Python shell

Development shell for Python projects.

Packages: `python3`, `python3Packages.pip`, `python3Packages.virtualenv`

## As a flake input

    inputs.pythonShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/python";

Reference `pythonShell.shellConfig.${system}.packages` and `pythonShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/python/` for a ready-to-use template.
