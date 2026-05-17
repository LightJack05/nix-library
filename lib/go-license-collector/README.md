# go-license-collector lib

Adds [go-license-collector](https://github.com/LightJack05/go-license-collector) to the dev shell. Useful for collecting and verifying Go dependency licenses.

Packages: `go-license-collector`.

## Adding to a template

1. Add the input:

       inputs.goLicenseCollectorLib.url = "git+https://gitea.lightjack.de/LightJack05/nix-library?dir=lib/go-license-collector";

2. Add the input name to the `outputs` function arguments.

3. Merge into the shell (in the clearly marked extension sections in any template):
   - Append `goLicenseCollectorLib.packages.${system}` to the packages list
