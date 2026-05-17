# .NET shell

Development shell for C# .NET projects.

Packages: `dotnet-sdk`

## As a flake input

    inputs.dotnetShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/dotnet";

Reference `dotnetShell.shellConfig.${system}.packages` and `dotnetShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/dotnet/` for a ready-to-use template.
