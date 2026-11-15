# Operator SDK shell

Development shell for Operator SDK-based Kubernetes operator projects. Extends the kubebuilder shell.

Packages: `go`, `gopls`, `gotools`, `delve`, `controller-tools`, `kustomize`, `kubectl`, `kind`, `operator-sdk`, `helmify`

## As a flake input

    inputs.operatorSdkShell.url = "git+https://github.com/LightJack05/nix-library?dir=shells/operator-sdk";

Reference `operatorSdkShell.shellConfig.${system}.packages` and `operatorSdkShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/operator-sdk/` for a ready-to-use template.
