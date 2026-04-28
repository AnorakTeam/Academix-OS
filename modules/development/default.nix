{ config, lib, ... }:

with lib;

{
  imports = [
    ./python.nix
    ./java.nix
    ./cpp.nix
    ./databases.nix
    ./docker.nix
    ./editors.nix
    ./office.nix
  ];

  options.academixos.development.enable = mkEnableOption "Enable all development tools";

  config = mkIf config.academixos.development.enable {
    # Development tools configuration
  };
}