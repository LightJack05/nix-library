# Bash shell

Development shell for Bash scripting projects.

Packages: `bash`, `shellcheck`, `shfmt`

## As a flake input

    inputs.bashShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/bash";

Reference `bashShell.shellConfig.${system}.packages` and `bashShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/bash/` for a ready-to-use template.
