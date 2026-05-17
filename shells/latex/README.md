# LaTeX shell

Dev shell for LaTeX projects. Includes the full TeX Live scheme plus formatting and vector graphics tooling.

Packages: `texlive.combined.scheme-full`, `perlPackages.LatexIndent`, `gnumake`, `inkscape`.

## As a flake input

    inputs.latexShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/latex";

Reference `latexShell.shellConfig.${system}.packages` and `latexShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/latex/` for a ready-to-use template.
