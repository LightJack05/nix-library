# Ansible shell

Dev shell for Ansible projects. Includes the Ansible toolchain plus linting, language server and password-based SSH support.

Packages: `ansible`, `ansible-lint`, `ansible-language-server`, `yamllint`, `sshpass`, `python3`.

## As a flake input

    inputs.ansibleShell.url = "git+https://github.com/LightJack05/nix-library?dir=shells/ansible";

Reference `ansibleShell.shellConfig.${system}.packages` and `ansibleShell.shellConfig.${system}.shellHook` to merge into your own dev shell.

See `templates/ansible/` for a ready-to-use template.
