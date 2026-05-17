{
  description = "C# .NET project dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    dotnetShell.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=shells/dotnet";
    generalLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/general";
    # --- Optional libs (uncomment input + merge lines below to enable) ---
    # podmanLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/podman";
    # qemuLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/qemu";
  };

  outputs = { self, nixpkgs, dotnetShell, generalLib, ... }:
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
          # ++ podmanLib.packages.${system}
          # ++ qemuLib.packages.${system}
          ;

          # --- Optional lib hooks (uncomment matching input above to enable) ---
          optionalHook = ""
          # + podmanLib.shellHook
          # + qemuLib.shellHook
          ;
        in
        {
          default = pkgs.mkShell {
            name = "dotnet-dev-shell";
            packages = dotnetShell.shellConfig.${system}.packages
              ++ generalLib.packages.${system}
              ++ optionalPackages
              ++ extraPackages;
            shellHook = dotnetShell.shellConfig.${system}.shellHook
              + generalLib.shellHook
              + optionalHook
              + extraShellHook;
          };
        }
      );
    };
}
