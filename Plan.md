# Nix flake template repo

This repo should contain several template nix flakes that can be included from projects. Here is the structure:

At root level, there are `templates`, `lib` and `shells` directories. The each contain a subdirectory corresponding to the appropriate project type, say `go` or `kubebuilder`.

## Shells
The flakes under `shells` should include the baseline setup for the specific project type, primarily the dev shell with the required packages. It should also include a shell hook that prints out the name of the included flake and the available packages with versions (ideally programmatically listed). I have put some examples of things I am using right now into `temp/`. 

## Libs
In addition to the `shells` directory, there should be an additional `lib` directory, which includes generic libraries that may be useful regardless of the project, like a podman flake or a qemu flake.
These libs should be includable dynamically from the flakes in templates, so I can modularly add them into the projects and easily add podman or qemu without having to list out the packages in the flake itself.

## Templates
Under `templates` there should be a template flake that includes the one under `shells`. This one should be the one I drop into the repo in the end, so the one that is inside the go project and pulls in the dependencies from the `shells` dir.
This one specifically should include an empty list of packages which I can use to add additional packages on top of the baseline shell. It should also include an empty shell hook I can use to inject env variables or print things etc.

In general: Just make sure these are easily extendable, they are the ones that will be dropped into the repo and will pull in everything from this repo.

## Required shells
For now, the following project types should be available in the repo to start with:
- Go
- Kubebuilder
- Operator SDK
- Python
- Bash
- C# .NET
- C
- NPM/JS

## Required Libs
The following Libs should be present:
- Podman
- Qemu
- General (this should include general tools like curl and GNU make, include in every flake under templates)
