# Kubebuilder shell

Development shell for Kubebuilder-based Kubernetes operator projects.

Packages: `go`, `gopls`, `gotools`, `delve`, `controller-tools`, `kustomize`, `kubectl`, `kind`

## As a flake input

    inputs.kubebuilderShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/kubebuilder";

Reference `kubebuilderShell.shellConfig.${system}.packages` and `kubebuilderShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/kubebuilder/` for a ready-to-use template.
