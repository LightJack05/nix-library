{
  description = "Python project dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    pythonShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/python";
    generalLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/general";
    podmanLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/podman";
    # --- Optional libs (uncomment input + merge lines below to enable) ---
    # kindLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/kind";
    # qemuLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/qemu";
  };

  outputs = { self, nixpkgs, pythonShell, generalLib, podmanLib, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # --- Add project-specific packages here ---
          extraPackages = [
          ];

          # --- Add project-specific shell hook here (env vars, startup messages, etc.) ---
          extraShellHook = ''
          '';

          # --- Optional lib packages (uncomment matching input above to enable) ---
          optionalPackages = []
          # ++ kindLib.packages.${system}
          # ++ qemuLib.packages.${system}
          ;

          # --- Optional lib hooks (uncomment matching input above to enable) ---
          optionalHook = ""
          # + qemuLib.shellHook
          ;
        in
        {
          default = pkgs.mkShell {
            name = "python-dev-shell";
            packages = pythonShell.shellConfig.${system}.packages
              ++ generalLib.packages.${system}
              ++ podmanLib.packages.${system}
              ++ optionalPackages
              ++ extraPackages;
            shellHook = pythonShell.shellConfig.${system}.shellHook
              + generalLib.shellHook
              + podmanLib.shellHook
              + optionalHook
              + extraShellHook;
          };
        }
      );
    };
}
