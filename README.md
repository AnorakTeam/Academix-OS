# Academix-OS

Made by:

- josemanuelpr@ufps.edu.co
- 
- 

## How to create the VM image

Following [the official Nix documentation](https://nix.dev/tutorials/nixos/nixos-configuration-on-vm), and making sure we are currently located at the root directory of [configuration.nix](./configuration.nix), execute the command:

```nix
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-25.11 -I nixos-config=./configuration.nix
```